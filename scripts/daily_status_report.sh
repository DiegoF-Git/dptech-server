#!/bin/bash
# Script to generate server status report
# Author: Diego Pedraza
# This script creates comprehensive server status reports

NOW=$(date +"%Y-%m-%d_%H-%M")
REPORT="/home/ubuntu/server_reports/report_$NOW.txt"

echo "===== SERVER STATUS REPORT =====" > $REPORT
echo "Date and Time: $(date)" >> $REPORT
echo "-------------------------------" >> $REPORT
echo "Uptime:" >> $REPORT
uptime >> $REPORT
echo "" >> $REPORT
echo "CPU and Memory Usage:" >> $REPORT
top -b -n1 | head -n 10 >> $REPORT
echo "" >> $REPORT
echo "Disk Usage:" >> $REPORT
df -h >> $REPORT
echo "" >> $REPORT
echo "Free Memory:" >> $REPORT
free -h >> $REPORT
echo "" >> $REPORT
echo "Top 5 Processes by Memory Usage:" >> $REPORT
ps aux --sort=-%mem | head -n 5 >> $REPORT

echo "Report saved to: $REPORT"