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
