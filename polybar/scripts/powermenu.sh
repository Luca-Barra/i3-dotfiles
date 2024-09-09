#!/bin/bash
options="  Shutdown\n  Reboot\n  Logout\n  Lock\n  Suspend"

choice=$(echo -e "$options" | rofi -dmenu -i -p "   Power Menu:" -theme-str '@import "/home/altair/.config/rofi/Miku2.rasi"')

case "$choice" in
    *Shutdown)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.PowerOff boolean:false
        ;;
    *Reboot)
        dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.Reboot boolean:false    
        ;;
    *Logout)
        i3-msg exit
        ;;
    *Lock)
        betterlockscreen -l
        ;;
    *Suspend)
        loginctl suspend
        ;;
    *)
        echo "No match found" >> $LOGFILE
        ;;
esac
