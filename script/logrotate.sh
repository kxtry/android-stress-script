#!/bin/sh

path_current=`pwd`
path_script=$(cd "$(dirname "$0")"; pwd)
path_data=$path_script/../data

yesterday=$(date -d "1 days ago" +%Y%m%d)
ndayago=$(date -d "15 days ago" +%Y%m%d)

for dir in $(ls -l ${path_data} | grep '^d' | awk '{ print $NF }'); do
    [ -d ${path_data}/${dir}/${yesterday} ] || mkdir -p ${path_data}/${dir}/${yesterday}
    [ -f ${path_data}/${dir}/error.txt ] && mv ${path_data}/${dir}/error.txt ${path_data}/${dir}/${yesterday}/error.txt
    [ -f ${path_data}/${dir}/tail.txt ] && mv ${path_data}/${dir}/tail.txt ${path_data}/${dir}/${yesterday}/tail.txt
    [ -d ${path_data}/${dir}/${ndayago} ] && rm -rf ${path_data}/${dir}/${ndayago}
done
adb disconnect


