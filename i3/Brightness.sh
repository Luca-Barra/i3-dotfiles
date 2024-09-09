#!/bin/zsh

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
    brightnessctl get | awk '{print $1}'
}

function get_max_brightness {
    brightnessctl max | awk '{print $1}'
}

function send_notification {
    brightness=$(get_brightness)
    max_brightness=$(get_max_brightness)
    percent=$(($brightness * 100 / $max_brightness))

    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($percent / 5)) | sed 's/[0-9]//g')

    # Send the notification
    dunstify -i display-brightness -t 2000 -r 2593 -u normal "    $bar"
}

case $1 in
    up)
        # Increase brightness (+ 5%)
        brightnessctl set +5%
        send_notification
        ;;
    down)
        # Decrease brightness (- 5%)
        brightnessctl set 5%-
        send_notification
        ;;
esac

