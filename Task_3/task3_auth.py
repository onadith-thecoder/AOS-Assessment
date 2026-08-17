##This is for Login / Access Control of the project submission system.

#First of all have to import importance
import json
import os
import sys
form datetime import datetime

#To remeber things between runs - log files
LOGIN_LOG_FILE = "login_log.txt"
ACCOUNTS_FILE = "accounts_status.json" #this will specially remember fail counts, lockstatus, last attempt time.

#Demo list for Valid Student Accounts (for simulation only)
#because here i dont use database...
VALID_USERS = {
    "student1": "password123"
    "student2": "password456"
    "student3": "password789"
}

MAX_FAILED_ATTEMPTS = 3         #after this may wrong passwords in a row, lock the account
SUSPICIOUS_WINDOW_SECONDS = 60  #attempts faster than this -> suspicious

def load_account_status():
    """Read the accounts_status.json file (creates it if it doesn't exist yet)."""
    if not os.path.exist(ACCOUNTS_FILE):
        return {}
    try:
        with open(ACCOUNTS_FILE, "r") as f:
            return json.load(f)
    except (json.JSONDecodeError, ValueError):
        #if the file got corrupted somehow, possible to start fresh instead of crashing
        return {}

def save_accounts_status(status_data):
    """Save the accounts_status.json file back to disk."""
    with open(ACCOUNTS_FILE, "w") as f:
        json.dump(status_data, f, indent=4)
