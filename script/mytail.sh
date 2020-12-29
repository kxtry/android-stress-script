#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
path_data=$path_script/../data

target=$1
param=$2
if [ "$target" == "" ]; then
   echo "should like mytail.sh 192.168.30.25 temp,frame"
   exit 1
fi

elapseLast=0
pidLast=0
while true
do
  run_time=$(date "+%Y%m%d%H%M")
  if [ ! -d "$path_data/${target}" ]; then
     mkdir -p "$path_data/${target}"
  fi
  echo "--------[${run_time}]----------------" >> $path_data/${target}/tail.txt
  /bin/bash $path_script/connect.sh $*
  adb -s "$target" shell "free -h" >> $path_data/${target}/tail.txt
# use crontab to replace it.
#  if [ $? -ne 0 ]; then
#     echo "bad echo and disconnect" >>  $path_data/${target}/tail.txt
#     adb disconnect
#  fi
  adb -s "$target" shell "top -n 1|grep com.commaai." >> $path_data/${target}/tail.txt
  sleep 1
  adb -s "$target" shell "top -n 1|grep com.commaai." >> $path_data/${target}/tail.txt
  app=$(adb -s "$target" shell "ps -ef|grep com.commaai|grep -v grep"|awk '{print $1}')
  if [ $? -eq 0 ]; then
     adb -s "$target" shell "lsof|grep $app|wc -l" | xargs echo "$app - filecount:" >> $path_data/${target}/tail.txt
  fi
  adb -s "$target" shell "ps -ef|grep com.commaai|grep -v grep" >> $path_data/${target}/tail.txt
  pid=$(adb -s "$target" shell "ps -ef|grep com.commaai|grep -v grep"|awk '{print $2}')
  if [ $? -eq 0 ]; then
     echo "app current pidLast:${pidLast} - pid:${pid}" >> $path_data/${target}/tail.txt
     if [ "$pid" == "" ]; then
        if [ "$pidLast" != "$pid" ]; then
           echo "app exit now:$pid" >> $path_data/${target}/tail.txt
        fi
     else 
        if [ "$pidLast" != "0" ]; then
           if [ "$pidLast" != "$pid" ]; then
              echo "app restart now:$pid" >> $path_data/${target}/tail.txt
              adb -s "$target" shell "stat /proc/$pid" >> $path_data/${target}/tail.txt
           fi
        fi
        adb -s "$target" shell "dumpsys meminfo $pid" >> $path_data/${target}/tail.txt
     fi
     pidLast=${pid}
  fi
  adb -s "$target" shell "lsof|wc -l" | xargs echo "filecount:" >> $path_data/${target}/tail.txt
  adb -s "$target" shell "cat /proc/uptime" >> $path_data/${target}/tail.txt
  elapse=$(adb -s "$target" shell "cat /proc/uptime"|awk '{print $1}')
  if [ "${elapse}" != "" ]; then
    echo "systerm current value last:${elapseLast} - now:${elapse}" >> $path_data/${target}/tail.txt
    if [ `echo "${elapseLast} > ${elapse}" | bc` -eq 1 ];then
       echo "systerm restart now last:${elapseLast} - now:${elapse}" >> $path_data/${target}/tail.txt
    fi
    elapseLast=${elapse}
  fi
  temp=$(echo $param | grep "temp")
  if [ "$temp" != "" ];then
     adb  -s "$target" shell "cat /sys/class/thermal/thermal_zone*/temp" >>  $path_data/${target}/tail.txt
  fi
  frame=$(echo $param | grep "frame")
  if [ "$frame" != "" ];then
     adb  -s "$target" shell "tail -n 2 /storage/emulated/0/Log/brokenflow.txt" >>  $path_data/${target}/tail.txt
  fi
  sleep 50
done
