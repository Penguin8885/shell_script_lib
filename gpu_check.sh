#!/bin/sh

if [ $# != 1 ];then
    echo "usage: $0 <sleep time>"
    exit 0
fi

sleeptime=$1
echo "sleep time = $sleeptime"
echo

read -sp 'pass: ' pass
echo
echo "================================"

while :
do
    echo "Searching available server"
    available_server=()
    unavailable_server=()


    for server in s01 s02 s03 s04
    do
        #echo $server

        hitnum=`sshpass -p $pass ssh $server 'nvidia-smi -q | grep "Processes                       : None" | wc -l'`
        if [ $hitnum != '0' ];then
            available_server+=( "$server" )
        else
            unavailable_server+=( "$server" )
        fi
    done

    echo
    date

    if [ ${#available_server[@]} = 0 ];then
        echo "-- GPU available server --"
    else
        echo -e "\033[0;31m-- GPU available server --\033[0;39m"
    fi
    echo "${available_server[@]}"
    echo "-- GPU unabailable server --"
    echo "${unavailable_server[@]}"
    echo
    echo "================================"

    sleep $sleeptime
done
