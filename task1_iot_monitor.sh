#!/bin/bash
# Smart Campus IoT Device Management Script

#Maintain a system_monitor_log.txt file.
LOG_FILE="system_monitor_log.txt"
ARCHIVE_DIR="ArchiveLogs"
CRITICAL_NAMES=("systemd" "init" "sshd" "cron" "kernel" "kthreadd")

#log action function - Record all administrative actions with timestamps
log_action() {
    echo "$(date '+%Y-%m-d% %H:%M:%S') - $1" >> "$LOG_FILE"
}

## (a) Process monitoring and management ## 
#function - Display CPU and memory usage
show_cpu_mem() {
    echo "**** CPU & Memory Usage ****"
    echo "CPU Load (1/10/20/30 min): $(uptime | awk -F'load average:' '{print $2}')"
    echo "Memory Usage:"
    free -h
    log_action "Displayed CPU and memory usage"
}
