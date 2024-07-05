#!/bin/bash
network=$(nmcli device status)

# get connection speed
#echo ${network:51:11}

if [[ $network == *"wifi      connected"* ]]; then
# show wifi icon according to signal
    signal=$(nmcli device wifi | grep "*" | awk '{print $8}')
    # echo $signal
    # if [[ $signal -gt 75 ]]; then
    #     echo "1"
    # elif [[ $signal -gt 50 ]]; then
    #     echo "2"
    # elif [[ $signal -gt 25 ]]; then
    #     echo "3"
    # else
    #     echo "4"
    # fi
    echo 
elif [[ $network == *"ethernet  connected"* ]]; then
    echo "󰈀"
else
    echo "󰖪"
fi
