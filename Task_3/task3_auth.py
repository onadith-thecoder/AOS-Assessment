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

MAX_FAILED_ATTEMPTS = 3         # after this may wrong passwords in a row, lock the account
SUSPICIOUS_WINDOW_SECONDS = 60  # attempts faster than this -> suspicious

