#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
path_data=$path_script/../;

target=$1
while true
do
  run_time=$(date "+%Y%m%d%H%M")
  /bin/bash $path_script/connect.sh $*
  if [ ! -d "$path_data/${target}" ]; then
     mkdir -p "$path_data/${target}"
  fi
  echo "--------[${run_time}]----------------" >> $path_data/${target}/error.txt
  adb -s "$target" logcat *:E >> $path_data/${target}/error.txt
done
