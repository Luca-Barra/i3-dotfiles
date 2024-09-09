#!/bin/bash

get_info() {
    echo "$(playerctl metadata title) - $(playerctl metadata artist)"
}

symbol() {
    local status=$(playerctl status 2> /dev/null)
    if [[ "$status" == "Playing" ]]; then
        echo ""
    elif [[ "$status" == "Paused" ]]; then
        echo ""
    else
        echo ""
    fi
}

scroll_text() {
    local window_len=$1
    local delay=${2:-0.25}

    local text=$(get_info)
    local padding='  '

    local text_length=${#text}
    local padding_len=${#padding}

    local padded_text="$text$padding"
    local total_len=$((text_length + padding_len))

    local symbol=$(symbol)  # Use local variable for symbol

    if ((text_length <= window_len)); then
        echo "${symbol}" "${padded_text}"
        return
    fi

    for ((i = 0; i < total_len; i++)); do
        new_text=$(get_info)
        symbol=$(symbol)

        if [[ "$new_text" != "$text" ]]; then
            return
        fi

        if ((i + window_len >= total_len)); then
            echo "${symbol}" "${padded_text:i}" "${padded_text:0:window_len - (total_len - i)}"
        else
            echo "${symbol}" "${padded_text:i:window_len}"
        fi
        sleep "$delay"

        # Check if mpv process is still running
   
    done
}

main() {
    local window_len=30
    local delay=0.2

    echo "Loading..." 
    sleep 10

    while true; do
        scroll_text ${window_len} ${delay}
    done

    echo "Stopping..." 
    sleep 3
}

main

