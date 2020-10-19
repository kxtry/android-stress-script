#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
ps -ef | grep "mylogcat" | grep -v grep
ps -ef | grep "mytail" | grep -v grep
ps -ef | grep "adb" | grep -v grep
