#!/bin/bash

echo "================ SYSTEM STATS ================"
echo

# -------- CPU USAGE --------
echo "Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print 100 - $8"% used"}'
echo

# -------- MEMORY USAGE --------
echo "Memory Usage:"
free -m | awk 'NR==2{
    used=$3;
    free=$4;
    total=$2;
    percent=($3/$2)*100;
    printf "Used: %sMB\nFree: %sMB\nTotal: %sMB\nUsage: %.2f%%\n", used, free, total, percent
}'
echo

# -------- DISK USAGE --------
echo "Disk Usage:"
df -h / | awk 'NR==2{
    printf "Used: %s\nFree: %s\nTotal: %s\nUsage: %s\n", $3, $4, $2, $5
}'
echo

# -------- TOP 5 CPU PROCESSES --------
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# -------- TOP 5 MEMORY PROCESSES --------
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo
