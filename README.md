# AOS-Assessment - Guide to go through

--------------------------------------------------------------------------------------------------------------------------------------------------------
## Repository Structure

```
AOS-Assessment/
│
├── task1_iot_monitor.sh        # Task 1 — IoT & System Resource Monitor
├── task2_job_scheduler.sh      # Task 2 — Priority-based Job Scheduler
│
├── Task_3/                             # Task 3 — User Authentication & Submission System
│   ├── submissions/                    # Submitted documents (act.docx, test1.docx)
│   ├── accounts_status.json            # JSON store for user account states
│   ├── login_log.txt                   # Log of all authentication attempts
│   ├── submission_log.txt              # Log of all submission events
│   ├── task3_auth.py                   # Python — user authentication module
│   └── task3_submission.sh             # Bash — submission handling script
│
├── ArchiveLogs/                        # Archived historical log files
├── test_logs/                  # Log outputs generated during testing
│
├── job_queue.txt               # Input queue file for the job scheduler
├── completed_jobs.txt          # Record of successfully completed jobs
├── scheduler_log.txt           # Runtime log produced by Task 2
└── system_monitor_log.txt      # Runtime log produced by Task 1
```

--------------------------------------------------------------------------------------------------------------------------------------------------------
## Tasks

### Task 1 — IoT & System Resource Monitor (`task1_iot_monitor.sh`)

A Bash script that continuously monitors system resources in the context of an IoT environment. It captures and logs key metrics such as CPU usage, memory consumption, disk utilisation, and running process states. All monitoring events are written to `system_monitor_log.txt` with timestamps, enabling historical analysis and threshold-based alerting.

**Key OS concepts covered:**
- Process monitoring and system calls
- Resource usage tracking (`/proc` filesystem interaction)
- File-based logging with timestamps
- Signal handling and daemon-style execution

**Usage:**
```bash
chmod +x task1_iot_monitor.sh
./task1_iot_monitor.sh
```

--------------------------------------------------------------------------------------------------------------------------------------------------------
### Task 2 — Job Scheduler (`task2_job_scheduler.sh`)

A Bash-based job scheduling system that reads jobs from a queue file (`job_queue.txt`), executes them according to defined criteria, and records outcomes. Completed jobs are appended to `completed_jobs.txt`, while the full execution trace is maintained in `scheduler_log.txt`.

**Key OS concepts covered:**
- Job queuing and batch processing
- Process scheduling strategies
- Inter-process communication via shared files
- Background process management with `&`, `wait`, and `jobs`

**Usage:**
```bash
chmod +x task2_job_scheduler.sh
./task2_job_scheduler.sh
```

**Job queue format (`job_queue.txt`):**
Each line represents a job entry to be scheduled and processed by the script.

--------------------------------------------------------------------------------------------------------------------------------------------------------
### Task 3 (`Task_3/`)

The third assessed task is contained within the `Task_3/` directory. Refer to the source files and any inline comments within that folder for implementation details.

A hybrid Python + Bash implementation of a user authentication and file submission management system. The task combines a Python authentication module with a Bash submission pipeline, demonstrating cross-language OS-level scripting and persistent state management via JSON and log files.

*Files:*

        File	                        Role
task3_auth.py       :-	Python script handling user login, credential verification, and account state management
task3_submission.sh :-	Bash script that manages the submission workflow — validating, processing, and logging file submissions
accounts_status.json:-	JSON data store tracking the status of each user account (active, locked, etc.)
login_log.txt       :-	Timestamped log of every authentication attempt (success and failure)
submission_log.txt  :-	Timestamped log of all submission events processed by task3_submission.sh
submissions/        :-	Directory holding submitted documents (act.docx, test1.docx)

*Key OS concepts covered:*

User authentication and access control logic
Persistent state management using structured JSON files
Cross-language scripting (Python + Bash interoperability)
File I/O and audit logging

# Run the authentication module
python3 Task_3/task3_auth.py

# Run the submission handler
chmod +x Task_3/task3_submission.sh
./Task_3/task3_submission.sh

--------------------------------------------------------------------------------------------------------------------------------------------------------
## Log Files

*Log Files*
        File	                            Description
system_monitor_log.txt      :-	Output log from Task 1; records resource metrics with timestamps
scheduler_log.txt           :-	Runtime execution trace generated by Task 2's scheduler
completed_jobs.txt          :-	Persistent record of all jobs that were successfully executed
job_queue.txt               :-	Input queue consumed by the job scheduler
Task_3/login_log.txt        :-	Log of all authentication attempts from Task 3
Task_3/submission_log.txt   :-	Log of all file submission events from Task 3
Task_3/accounts_status.json :-	Persistent JSON store for user account states
ArchiveLogs/                :-	Historical log archives from previous test runs
test_logs/                  :-	Logs produced during development and testing phases

--------------------------------------------------------------------------------------------------------------------------------------------------------
## Prerequisites

-Prerequisites
-Linux-based operating system (Ubuntu recommended)
-Bash shell (bash --version ≥ 4.x)
-Python 3 (python3 --version) — required for Task 3
-Standard GNU coreutils (awk, grep, top, df, free, ps)
-Execute permissions on the scripts

--------------------------------------------------------------------------------------------------------------------------------------------------------
## Running the Scripts

# Clone the repository
git clone https://github.com/onadith-thecoder/AOS-Assessment.git
cd AOS-Assessment

# Make scripts executable
chmod +x task1_iot_monitor.sh task2_job_scheduler.sh Task_3/task3_submission.sh

# Run Task 1 — IoT Monitor
./task1_iot_monitor.sh

# Run Task 2 — Job Scheduler
./task2_job_scheduler.sh

# Run Task 3 — Authentication module
python3 Task_3/task3_auth.py

# Run Task 3 — Submission handler
./Task_3/task3_submission.sh

> **Note:** Depending on your system configuration, some monitoring commands may require elevated privileges (`sudo`).

--------------------------------------------------------------------------------------------------------------------------------------------------------

## Author

**Venuka Onadith**
B.Eng (Hons) Software Engineering Undergraduate — CCCU via Saegis Campus
[GitHub](https://github.com/onadith-thecoder) · [Portfolio](https://venuka-onadith.vercel.app)

