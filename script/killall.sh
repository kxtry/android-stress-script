#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
echo "try to kill mylogcat"
while true
do
  app_process=$(ps -ef | grep "mylogcat" | grep -v grep)
  echo $app_process | awk '{print ($2)}'
  stop=1
  if test -n "$app_process"; then
    echo "had find app process informaton"
    echo $app_process | awk '{print ($2)}' | xargs kill -9
    stop=0
  fi
  if [ $stop -eq 1 ]; then
    break
  fi
done

echo "try to kill mytail"
while true
do  
  app_process=$(ps -ef | grep "mytail" | grep -v grep)
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


echo "try to kill adb"
while true
do  
  app_process=$(ps -ef | grep "adb" | grep -v grep)
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
