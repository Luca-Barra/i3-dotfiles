#!/bin/bash

# File to store the mpv process ID
MPV_PID_FILE="/tmp/mpv_youtube_audio.pid"

# Function to play YouTube audio using mpv
play_youtube_audio() {
    local video_url="$1"

    stop_youtube_audio
    
    # Play the video with audio only, and run mpv in the background
    mpv --no-video --script=/usr/share/mpv/scripts/mpris.so "$video_url" &
    
    # Store the mpv process ID
    echo $! > "$MPV_PID_FILE"
}

# Function to stop the currently playing YouTube audio
stop_youtube_audio() {
    if [ -f "$MPV_PID_FILE" ]; then
        # Read the mpv process ID
        mpv_pid=$(cat "$MPV_PID_FILE")

        # Check if the process is running
        if ps -p "$mpv_pid" > /dev/null; then
            # Kill the mpv process
            kill "$mpv_pid"
        else
            rofi -e "No music is currently playing"
        fi
        
        # Remove the PID file
        rm "$MPV_PID_FILE"
    fi
    sleep 5
}

# Prompt the user for an action
action=$(echo -e "󰐊 Play Music\n󰓛 Stop Music" | rofi -dmenu -i -p "Select Action:"  -theme-str '@import "/home/altair/.config/rofi/Music.rasi"')

# Exit if no action was selected
if [ -z "$action" ]; then
    exit 1
fi

if [ "$action" == "󰐊 Play Music" ]; then
    # Prompt the user for a search query
    query=$(rofi -dmenu -p "Search YouTube:"  -theme-str '@import "/home/altair/.config/rofi/Music.rasi"')

    # Exit if the query is empty
    if [ -z "$query" ]; then
        exit 2
    fi

    # Fetch the YouTube search results using yt-dlp
    results=$(yt-dlp "ytsearch10:$query" --print "󰝚 %(title)s|%(id)s" --flat-playlist)

    # Check if yt-dlp returned any results
    if [ -z "$results" ]; then
        rofi -e "No results found for \"$query\""
        exit 1
    fi

    # Display the results in Rofi and get the selected line
    selection=$(echo "$results" | rofi -dmenu -i -p "Select Video:"  -theme-str '@import "/home/altair/.config/rofi/Music.rasi"')

    # Exit if no selection was made
    if [ -z "$selection" ]; then
        exit 1
    fi

    # Extract the video ID from the selected line
    video_id=$(echo "$selection" | awk -F'|' '{print $2}')

    # Play the selected video with audio only using mpv
    play_youtube_audio "https://www.youtube.com/watch?v=$video_id"
elif [ "$action" == "󰓛 Stop Music" ]; then
    # Stop the currently playing YouTube audio
    stop_youtube_audio
fi

