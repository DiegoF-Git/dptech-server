#!/bin/bash
# Apache Monitoring Script
# Author: Diego Pedraza
# Monitors Apache service and automatically restarts if needed

LOGFILE="/home/ubuntu/apache_logs/apache_monitor.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Checking Apache service..." >> $LOGFILE

# Check if Apache is active
if systemctl is-active --quiet apache2
then
    echo "[$TIMESTAMP] Apache is running." >> $LOGFILE
else
    echo "[$TIMESTAMP] Apache is NOT running. Restarting..." >> $LOGFILE
    sudo systemctl start apache2
    if systemctl is-active --quiet apache2
    then
        echo "[$TIMESTAMP] Apache successfully restarted." >> $LOGFILE
    else
        echo "[$TIMESTAMP] Failed to restart Apache!" >> $LOGFILE
    fi
fi