#!/bin/bash

datetime=$(date +"%D %T")

# watch processor temp
temperature=$(vcgencmd measure_temp | awk -F"=" '{print $2}')
cpu_temp=$(echo $temperature | sed 's/[^0-9.]//g')

# watch cpu and memory's load
#cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
load=$(uptime | awk -F'load average: ' '{print $2}' | cut -d',' -f1-3)

memory_usage=$(free -m | awk 'NR==2{printf "%.2f", $3/$2}')
swap_usage=$(free -m | awk 'NR==3{printf "%.2f", $3/$2}')

# monitor disk space
disk_usage=$(df -h / | awk 'NR==2{printf "%.2f", $5/100}')

# internet test
internet=$(ping -c 1 -W 1 www.google.com &> /dev/null && echo Online || echo Offline)

# monitor network usage
#network_connections=$(netstat -tuln | awk 'NR>2{print $6}' | sort | uniq -c | awk '{print $2":"$1}')

# get last login (usefuyll to know who accessed your device)
#last_logins=$( last -n 5 --time-format notime -R)

# las system event
#recent_events=$(journalctl --since "10 minutes ago" --no-pager -p err..emerg)

# Is security up to date ?
#security_updates=$(apt list --upgradable 2>/dev/null | grep -i security)

csv_header_output='date,temperature,load 1 minute,load 5 minutes,load 15 minutes,memory usage,swap usage,disk usage,internet'

# log concatenation
csv_output=''$datetime','$cpu_temp','$load','$memory_usage','$swap_usage','$disk_usage','$internet''

#FILE='monitor.csv'
#if [ -f $FILE ]; then
#   echo $csv_output >> $FILE
#else
#   echo $csv_header_output >> $FILE
#   echo $csv_output >> $FILE
#fi

if [[ $1 == "csv" ]]; then
  FILE='monitor.csv'
  if [ -f $FILE ]; then
    echo $csv_output >> $FILE
  else
    echo $csv_header_output >> $FILE
    echo $csv_output >> $FILE
  fi
else
  echo $csv_output
fi
