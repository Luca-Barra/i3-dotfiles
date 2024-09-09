#!/bin/bash

# List all rice configurations
RICE_DIR="$HOME/.rice"
rices=$(ls -1 "$RICE_DIR")

# Show the list using rofi and capture the selected rice
selected_rice=$(echo "$rices" | rofi -dmenu -p "Select a rice")

# If a rice was selected, apply it
if [ -n "$selected_rice" ]; then
    /home/$USER/.config/i3/apply_rice.sh "$selected_rice"
fi

