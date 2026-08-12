#!/bin/bash
# Smart Campus IoT Device Management Script

LOG_FILE="system_monitor_log.txt"
ARCHIVE_DIR="ArchiveLogs"
CRITICAL_NAMES=("systemd" "init" "sshd" "cron" "kernel" "kthreadd")

#log action - function
log_action() {
    echo "$(date '+%Y-%m-d% %H:%M:%S') - $1" >> "$LOG_FILE"
}
