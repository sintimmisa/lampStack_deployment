#!/bin/bash

# Uptime information
uptime_info=$(uptime)

# Extract uptime 
uptime_value=$(echo "${uptime_info"}  | awk '{print $3}')


# Log information
echo "$(date) - Server uptime: ${uptime_value}" >> /var/log/uptime.log