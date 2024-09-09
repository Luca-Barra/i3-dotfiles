#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
MONITORS=$(xrandr --query | grep " connected" | cut -d" " -f1)

MONITORS=$MONITORS polybar mainbar-poly;
# MONITOR=$MONITORS polybar 2-bottom? &
# MONITOR=$MONITORS polybar 3;
# polybar mainbar-poly ~/.config/polybar/config.ini & disown

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar mainbar-poly 2>&1 | tee -a ~/.config/polybar/config.ini & disown

polybar-msg cmd quit
 
echo "Polybar launched..."

