#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
path_data=$path_script/../

target=$1
param=$2
if [ "$target" == "" ]; then
   echo "should like mytail.sh 192.168.30.25 temp,frame"
   exit 1
fi

while true
do
  run_time=$(date "+%Y%m%d%H%M")
  if [ ! -d "$path_data/${target}" ]; then
     mkdir -p "$path_data/${target}"
  fi
  echo "--------[${run_time}]----------------" >> $path_data/${target}/tail.txt
  /bin/bash $path_script/connect.sh $*
  adb -s "$target" shell "free -h" >> $path_data/${target}/tail.txt
  adb -s "$target" shell "top -n 1|grep com.commaai." >> $path_data/${target}/tail.txt
  sleep 1
  adb -s "$target" shell "top -n 1|grep com.commaai." >> $path_data/${target}/tail.txt
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
