#!/bin/zsh

while true; do
    # Check for updates on Arch Linux
    aur_updates=$(yay -Qu 2> /dev/null | wc -l)
    pacman_updates=$(checkupdates 2> /dev/null | wc -l)

    # AUR = 
    # PACMAN = 

    if [ "$aur_updates" -gt 0 ] && [ "$pacman_updates" -gt 0 ]; then
        echo " $aur_updates,  $pacman_updates"
    elif [ "$aur_updates" -gt 0 ]; then
        echo " $aur_updates"
    elif [ "$pacman_updates" -gt 0 ]; then
        echo " $pacman_updates"
    else
        echo ""
    fi

    # Wait for 30 minutes (1800 seconds) before the next check
    sleep 1800
done
