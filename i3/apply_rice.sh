#!/bin/zsh

# Directory where your rice configurations are stored
RICE_DIR="$HOME/.rice"

# Apply the selected rice
apply_rice() {
    local RICE="$1"
    cp "$RICE_DIR/$RICE/i3config" "$HOME/.config/i3/config"
    cp "$RICE_DIR/$RICE/polybarconfig" "$HOME/.config/polybar/config.ini"
    feh --bg-scale "$RICE_DIR/$RICE/wallpaper.jpg"
    i3-msg restart
    polybar-msg cmd restart
}

# Check if a rice name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <rice_name>"
    exit 1
fi

apply_rice "$1"
