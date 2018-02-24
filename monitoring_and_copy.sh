#!/bin/bash

if [ $# != 3 ];then
    echo "usage: $0 <copy target file> <monitoring log file> <keyword>"
    exit 0
fi

cp_file=$1
monitoring_logfile=$2
keyword=$3

echo "copy target file: $cp_file"
echo "monitoring log file: $monitoring_logfile"
echo "keyword: $keyword"

sleeptime=5
skiptime=300

while true; do
    flag=`tail $monitoring_logfile | grep $keyword | wc -l`

    if [ $flag != 0 ] ; then
        echo "updated: `date`"
        cp $cp_file `date +%Y%m%d_%H%M%S`.tar
        sleep $skiptime
    fi
    sleep $sleeptime
done
