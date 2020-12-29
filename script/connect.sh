#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

target=$1
if [ "$target" == "" ]; then
   echo "should add parameter to connect command, like connect.sh 192.168.30.25:5555"
   exit 1
fi
# use crontab to replace disconnect.
# */10 * * * * /usr/bin/adb disconnect && echo $(date) >> /root/adbdisconnect.txt
#
#adb -s "$target" shell "ls" > /dev/null 2>&1
#if [ $? -ne 0 ]; then
#   echo "bad echo and disconnect" >>  $path_data/${target}/tail.txt
#   adb disconnect
#fi
result=$(adb devices|grep "${target}"|grep -v offline|grep -v grep)
if [ "$result" != "" ]; then
   exit 0
fi
#for i in {1..30}
#do
#adb disconnect
#done
adb connect $target
adb -s "$target" root

