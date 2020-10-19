#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

target=$1
if [ "$target" == "" ]; then
   echo "should add parameter to connect command, like connect.sh 192.168.30.25:5555"
   exit 1
fi
result=$(adb devices|grep "${target}"|grep -v offline|grep -v grep)
if [ "$result" != "" ]; then
   exit 0
fi
adb connect $target
adb -s "$target" root

