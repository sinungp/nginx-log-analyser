#!/bin/bash

# Script: analyze-nginx-logs.sh
# Purpose: Analyze an Nginx access log file and provide statistical summaries.

LOG_FILE="nginx-access.log"

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found."
    echo "Download the log file from the provided URL."
    exit 1
fi

# Extract and display the top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo

# Extract and display the top 5 most requested paths
echo "Top 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo

# Extract and display the top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo

# Extract and display the top 5 user agents
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{for (i=2; i<=NF; i++) printf $i " "; print "- " $1 " requests"}'

echo
