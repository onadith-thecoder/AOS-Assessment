#!/bin/bash

#Base setup for keep logs.
SUBMISSION_FOLDER="submissions"
LOG_FILE="submission_log.txt"
MAX_SIZE_BYTES=$((5 * 1024 * 1024))

#To make sure if submission folder exists before try to use it.
mkdir -p "$SUBMISSION_FOLDER"

#To make sure log file is exists.
touch "$LOG_FILE"

#function for write log file with timestamp
write_log() {
    local message="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" >> "$LOG_FILE"
}
