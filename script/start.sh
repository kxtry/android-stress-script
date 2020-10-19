#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

target=$1
param=$2
if [ "$target" == "" ]; then
   echo "should like run.sh 192.168.30.25:5555 temp,frame"
   exit 1
fi

nohup /bin/bash ${path_script}/mytail.sh $* &
nohup /bin/bash ${path_script}/mylogcat.sh $* &
