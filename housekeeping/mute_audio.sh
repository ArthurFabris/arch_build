#!/bin/bash

# Check if the system is currently muted
is_muted=$(pamixer --get-mute)

# Toggle mute/unmute
if [ "$is_muted" = "true" ]; then
    pamixer --unmute
    echo "Unmuted"
    dunstify -r 9990 -u low -i /home/arthur/housekeeping/unmute_icon.png "Audio Unmuted"
else
    pamixer --mute
    echo "Muted"
    dunstify -r 9990 -u low -i /home/arthur/housekeeping/mute_icon.png "Audio Muted"
fi
