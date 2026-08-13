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

#Show all jobs waiting in line
show_Waiting_jobs() {
    if [[ ! -f "$QUEUE_FILE" || ! -s "$QUEUE_FILE" ]]; then
        echo "No waiting jobs. The line is empty!"
    else
        echo "Waiting Jobs in line (Format: StudentsID|JobName|ExecTime|Priority):"
        cat "$QUEUE_FILE"
    fi
}

