#!/bin/bash



DIVIDE(){ echo "---------------------------" 
}
#CPU=`cat /proc/cpuinfo |grep "processor"|wc -l`
#MEMORY=`free -mh |grep Mem |awk '{print $2}'`
echo "配置为
`cat /proc/cpuinfo |grep "processor"|wc -l`核 `free -mh |grep Mem |awk '{print $2}'`" && DIVIDE
uptime && DIVIDE
dmesg -V &> /dev/null && dmesg |tail -10 && DIVIDE
vmstat -V &> /dev/null && vmstat 1 5 && DIVIDE
mpstat -V &> /dev/null && mpstat 1 5 && DIVIDE
pidstat -V &> /dev/null && pidstat 1 3 && DIVIDE
iostat -V &> /dev/null && iostat -xz 1 3 && DIVIDE
sar -V &> /dev/null && sar -n DEV 1 3 && DIVIDE
sar -V &> /dev/null && sar -n TCP,ETCP 1 3 && DIVIDE
top -n 1 |grep -A 3 "running"
