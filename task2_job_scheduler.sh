#!/bin/bash

## Task 2 - University research cluster job scheduler ##

QUEUE_FILE="job_queue.txt"
COMPLETED_FILE="completed_jobs.txt"
LOG_FILE="scheduler_log.txt"
TIME_QUANTUM=5 #how many seconds each job gets per turn

#log record function for note down every move
write_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

#function: Show all jobs waiting in line
show_Waiting_jobs() {
    if [[ ! -f "$QUEUE_FILE" || ! -s "$QUEUE_FILE" ]]; then
        echo "No waiting jobs. The line is empty!"
    else
        echo "Waiting Jobs in line (Format: StudentsID|JobName|ExecTime|Priority):"
        cat "$QUEUE_FILE"
    fi
}

#function: Add a new job
add_job() {
    read -p "Student ID: " sid
    read -p "Job Description: " jdesc
    read -p "How many secounds will it takes? " etime
    read -p "Priority (1 most, 10 least): " prior

    if [[ ! "$etime" =~ ^[0-9]+$ ]] || [[ ! "$prior" =~ ^[1-9]$|^10$ ]]; then
        echo "Invalid time or priority."
        return
    fi
        echo "$sid|$jdesc|$etime|$prior" >> "$QUEUE_FILE"
        write_log "job added: $sid|$jdesc|$etime|$prior"
        echo "Job added!"
}

#function: process queue acording to round robin 
process_rr() {
    if [[ ! -f "$QUEUE_FILE" || ! -s "$QUEUE_FILE" ]]; then
        echo "The line is empty, nothing to do."
        return
    fi
        echo "Processing with Round Robin (quantum=$TIME_QUANTUM s)..."

        #this will read the queue in to array, and process until all done
        declare -a jobs
        mapfile -t jobs < "$QUEUE_FILE"

        #Clear queue
        > "$QUEUE_FILE"
            local completed=()

        #loop untill all jobs finished
        while [[ ${#jobs[@]} -gt 0 ]]; do
            for idx in "${!jobs[@]}"; do

            IFS='|' read -r sid jdesc etime prio <<< "${jobs[$idx]}"
                if (( etime <= TIME_QUANTUM )); then

                # Job completes
                echo "Job $jdesc (ID: $sid) completed (ran for $etime s)."
                completed+=("$sid|$jdesc|$etime|$prior|completed_$(date '+%Y%m%d_%H%M%S')")
                write_log "RR: Job $jdesc completed for $sid"
                unset 'jobs[$idx]'
            else
                # Run for quantum then reduce time
                let etime-=TIME_QUANTUM
                echo "Job $jdesc (ID: $sid) ran for quantum, remaining $etime s."
                jobs[$idx]="$sid|$jdesc|$etime|$prior"
                write_log "RR: job $jdesc ran quantum, remaining $etime s"
            fi
        done
        
        #Re-index array
        jobs=("${jobs[@]}")
    done

    #Append completed to completed file
    for c in "${completed[@]}"; do
        echo "$c" >> "$COMPLETED_FILE"
        done

        echo "All jobs processed."
}

#function: show all the finished jobs
show_finished_jobs() {
    if [[ ! -s "$COMPLETED_FILE" || ! -s "$COMPLETED_FILE" ]]; then
        echo "Nothing finished yet."
    elsse
        echo "Finished jobs: "
        cat "$COMPLETED_FILE"
    fi
}