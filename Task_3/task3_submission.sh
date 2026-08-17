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

#(01)
#Submit an Assignment
submit_assignment() {
    echo ""
    read -rp "Enter the full path of the file you want to submit: " file_path

    #checking process - file exists on the computer?
    if [ ! -f "$file_path" ]; then
        echo "ERROR: that file doesn't exist. Plz check the path and try again later!"
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
    file_size=$(stat -c%s "$file_path" 2>/dev/null || stat -f%z "$file_path")
    if [ "$file_size" -gt "$MAX_SIZE_BYTES" ]; then
        echo "ERROR: File size is too large. Max Allowed size is 5MB!"
        write_log "REJECTED - '$file_name' : is too large ($file_size bytes)"
        return
    fi

    #Rule for reject duplicate submissions (same file name or same content(hash))
    file_hash=$(md5sum "$file_path" | awk '{print $1}') #md5sum method for create a fingerprint of the content for each file
    
    #this will look through log file for previous accepted submissions with the same file name and same content (fingerprint)
    if grep -q "ACCEPTED - '$file_name' - hash:$file_hash" "$LOG_FILE"; then
        echo "ERROR: Duplicate (this file has already been submitted before)."
        write_log "REJECTED - '$file_name' - duplicat esubmission (hash:$file_hash)"
        return
    fi

    #if everything is ok then; copy the file in to submission folder
    cp "$file_path" "$SUBMISSION_FOLDER/$file_name"
        echo "DONE: '$file_name' has been successfully submitted."
        write_log "ACCEPTED - '$file_name' - hash:$file_hash - size:${file_size} bytes"
}

#(02)
#Checking proccess for already submited files
check_submission() {
    echo ""
    read -rp "Enter Your File Name to Check (With extension): " file_name

    if grep -q "Accepted - '$file_name' - hash: " "$LOG_FILE"; then
        echo "YES - '$file_name' has already been submitted."
    else
        echo "NO - '$file_name' has not been submitted yet."
    fi
}

#(03)
#function: for list all submitted assignments
list_submission() {
    echo ""
    echo "==== SUBMITTED ASSIGNMENTS ===="
    if [ -z "$(ls -A "$SUBMISSION_FOLDER" 2>/dev/null)" ]; then
        echo "No Assignments have been submitted yet."
    else
        ls -1 "$SUBMISSION_FOLDER"
    fi
}

#(04)
#function: for simulate a login attempt
simulate_login() {
    echo ""
    read -rp "Enter Username: " username
    read -rsp "Enter Password: " password
    echo "" #this willmove to a new line right after the hidden password input

    #this will check all credentials correct, then writing them to login_log.txt as well.
    python3 task3_auth.py "$username" "$password"
}

#(05)
#function for Exit with Confirmation
exit_system() {
    echo ""
    read -rp "Are you sure you want to exit ? (Y/N): " confirm
    if [ "$confirm" == "y" ] || [ "$confirm" == "y" ]; then
        echo "Goodbye !!!"
        exit 0
    else
        echo "Exit Cancelled. Directing to Main Menu."
    fi
}

#************** Main Menu **************

while true; do
    echo ""
    echo "--------------------------------------------------------------"
    echo " * Wellcome to Project Submission and Authentication System * "
    echo "--------------------------------------------------------------"
        echo "(1) Submit an Assignment"
        echo "(2) Check if a file has Already been Submitted"
        echo "(3) List all Submitted Assignments"
        echo "(4) Simulate Login Attempt"
        echo "(5) Exit"
    echo "--------------------------------------------------------------"
    read -rp "Choose an option (1-5): " choice

    case "$choice" in
        (1) submit_assignment ;;
        (2) check_submission ;;
        (3) list_submission ;;
        (4) simulate_login ;;
        (5) exit_system ;;
        (*) echo "Invalid option. Please choose a number between 1 and 5." ;;
    esac
done