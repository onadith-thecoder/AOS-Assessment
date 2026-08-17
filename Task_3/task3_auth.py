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

def log_attempt(username, result_message):
    """Write one line to login_log.txt every time someone tries to log in. it will always include the date & time, it's will helped as a audit"""

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(LOGIN_LOG_FILE, "a") as f:
        f.write(f"[{timestamp}] Username: {username} -> {result_message}\n")

def simulate_login(username, password):
    """This is the main function. run & checks everything and return a message to the user"""

    accounts_status = load_account_status()
    now = datetime.now()

    #if new username occured, this will set up a new record of it.
    if username not in accounts_status:
        accounts_status[username] = {
            "failed_attempts": 0,
            "locked": False,
            "last_attempt_time": None,
        }
    account = accounts_status[username]

#(01)
#Checking process - Account already locked
if account["locked"]:
    message = "ACCOUNT LOCKED !!!"
    log_attempt(username, message)
    save_accounts_status(accounts_status)
    return message

#(02)
#Checking process - Suspicious speed of repeated attempts
suspicious = False
    if account["last_attempt_time"] is not None:
        last_time = datetime.strptime(account["last_attempt_time"], "%Y-%m-%p %H:%M:%S")
        seconds_since_last_attempt = (now - last_time).total_seconds()
        if seconds_since_last_attempt < SUSPICIOUS_WINDOW_SECONDS:
            suspicious = True
    #update last attempt time to right now, for next time check
    account["last_attempt_time"] = now.strftime("%Y-%m-%p %H:%M:%S")

#(03)
#Checking process - username exists & passwor is correct
if username not in VALID_USERS or VALID_USERS[username] != password:
    
    #wrong username or wrong password counting as a failed attempt
    account["failed_attempts"] += 1

    if account["failed_attempts"] >= MAX_FAILED_ATTEMPTS:
        account["locked"] = True
        message = "LOGIN FAILED!!! Accont is now locked, you tried more thatn 3 attempts."
    else:
        remaining = MAX_FAILED_ATTEMPTS - account["failed_attempts"]
        message = f"LOGIN FAILED!!! Incorrect username or password, {remaining} attempt(s) left."
    
    if suspicious:
        message += " [SUSPICIOUS: repeated attempts within 60 seconds]"

        log_attempt(username, message)
        save_accounts_status(accounts_status)
        return message

#(04)
#A correct login resets the failed attempt counter back to 0
account["failed_attempts"] = 0
message = "LOGIN SUCCESSFUL!!! Welcome, " + username + "."

if suspicious:
    message += "[SUSPICIOUS: repeated attempts within 60 seconds]"

    log_attempt(username, message)
    save_accounts_status(accounts_status)
    return message

if __name__ == "__main__":
    #this script able to run directly from terminal or called by the bash menu like; python3 task3_auth.py <username> <password>
    if len(sys.argv) != 3:
        print("Usage: python3 task3_auth.py <username> <password>")
        sys.exit(1)

    entered_username = sys.argv[1]
    entered_password = sys.argv[2]

    result = simulate_login(entered_username, entered_password)
    print(result)