#!/bin/bash

pid=0
active=false

while true; do
    status=$(playerctl status 2> /dev/null)
    echo "$status"

    echo "$active"

    echo "$pid"

    if [[ "$status" == *"Playing"* || "$status" == *"Paused"* ]]; then
        if [[ "$active" = false ]]; then
            # start polybar and get pid
            polybar player & disown
            pid=$!
            active=true
            echo "actived"
        fi
    else
        if [[ "$active" = true ]]; then
            # kill polybar
            kill $pid
            active=false
            echo "stopped"
        fi
    fi

    sleep 1
done
