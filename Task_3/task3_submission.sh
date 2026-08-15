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
        write_log "FAILED SUBMISSION - file not found: $file_path"
        return
    fi

    #to get the file name (without the folder path in front of it).
    file_name=$(basename "$file_path")

    #to get the file extention in lowercase.
    extension="${file_name##*.}"
    extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    #Rule for allowed file formats.
    if [ "$extension_lower" != "pdf" ] && [ "$extension_lower" != "docx" ]; then
        echo "ERROR: Only .pdf and .docx files are accepted."
        write_log "REJECTED - '$file_name' - invalid file type (.$extension_lower)"
        return
    fi

    #Rule for maximum file size.
    file_size=$(start -c%$ "$file_path" 2>/dev/null || stat -f%z "$file_path")
    if [ "$file_size" -gt "$MAX_SIZE_BYTES" ]; then
        echo "ERROR: File size is too large. Max Allowed size is 5MB!"
        write_log "REJECTED - '$file_name' : is too large ($file_size bytes)"
        return
    fi

    
}