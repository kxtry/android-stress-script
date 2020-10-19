#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)

while true
do
   /bin/bash $path_script/script/check.sh
   read -p "input action[killall|start|stop|help|exit]:" mode
   case "$mode" in
     'start')
        read -p "input device IP[192.168.30.25]: " ip
        read -p "input watch type such as [temp,frame,none],default none: " type
        echo "start parameter: IP: $ip  -  type:$type"
        if [ "$ip" != "" ]; then
            /bin/bash $path_script/script/start.sh "$ip:5555" "$type"
        fi
        if [ "$ip" == "" ]; then
           echo "IP should not be empty"
        fi
     ;;
     'stop')
        read -p "input device IP[192.168.30.25]: " ip
        echo "stop parameter: IP: $ip  -  type:$type"
        if [ "$ip" != "" ]; then
           /bin/bash $path_script/script/stop.sh "$ip:5555"
        fi
     ;;
     'killall')
         /bin/bash $path_script/script/killall.sh
     ;;
     'exit')
         exit 0
     ;;
     *)
     ;;
   esac     
done
