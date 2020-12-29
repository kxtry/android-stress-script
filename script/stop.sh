#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

target=$1
if [ "$target" == "" ]; then
   echo "should like 192.168.30.25:5555"
   exit 1
fi

ps -ef | grep "$target"| grep -v grep

while true
do
  app_process=`ps -ef | grep "$target"| grep -v grep|grep -v stop.sh`
  echo $app_process | awk '{print ($2)}'
  stop=1
  if test -n "$app_process"; then
     echo "had find app process informaton"
     echo $app_process | awk '{print ($2)}' | xargs kill -9
     stop=0
  fi
  if [ $stop -eq 1 ]; then
    break;
  fi
done
