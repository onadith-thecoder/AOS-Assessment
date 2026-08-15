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

#Submit an Assignment
submit_assignment() {
    echo ""
    read -rp "Enter the full path of the file you want to submit: " file_path

    #checking process - file exists on the computer?
    if [ ! -f "$file_path" ]; then
        echo "ERROR: that file does't exist. Plz check the path and try again later!"
        log_message "FAILED SUBMISSION - file not found: $file_path"
        return
    fi
}