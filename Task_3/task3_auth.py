##This is for Login / Access Control of the project submission system.

#First of all have to import importance
import json
import os
import sys
form datetime import datetime

#To remeber things between runs - log files
LOGIN_LOG_FILE = "login_log.txt"
ACCOUNTS_FILE = "accounts_status.json" #this will specially remember fail counts, lockstatus, last attempt time.

