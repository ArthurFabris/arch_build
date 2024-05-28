#!/bin/bash
# Get the current brightness
BRIGHTNESS=$(xbacklight -get | cut -d '.' -f 1)

# Check if brightness is above 10%
if [ "$BRIGHTNESS" -gt 10 ]; then
    # Decrease brightness by 10%
    xbacklight -dec 10
    BRIGHTNESS=$((BRIGHTNESS - 10))
elif [ "$BRIGHTNESS" -eq 10 ]; then
    # Decrease brightness by 1%
    xbacklight -dec 1
    BRIGHTNESS=$((BRIGHTNESS - 1))
else
    # Decrease brightness by 1% if not already at 1%
    if [ "$BRIGHTNESS" -gt 1 ]; then
        xbacklight -dec 1
        BRIGHTNESS=$((BRIGHTNESS - 1))
    fi
    # Ensure brightness doesn't go below 1%
    if [ "$BRIGHTNESS" -lt 1 ]; then
        BRIGHTNESS=1
        xbacklight -set 1
    fi
fi

NUM_HASHES=$(( (BRIGHTNESS * 20 / 100) + 1))

# Ensure NUM_HASHES does not exceed 20
if [ "$NUM_HASHES" -gt 20 ]; then
    NUM_HASHES=20
fi

# Construct the progress bar string
PROGRESS_BAR=""
for ((i = 0; i < NUM_HASHES; i++)); do
    PROGRESS_BAR+="#"
done

# Calculate the number of '_' characters
NUM_UNDERSCORES=$((20 - NUM_HASHES))

# Add the '_' characters to the progress bar string
for ((i = 0; i < NUM_UNDERSCORES; i++)); do
    PROGRESS_BAR+="--"
done

# Show notification with the brightness progress bar
dunstify -r 9992 -u low -i /home/arthur/housekeeping/decrease_icon.png "$BRIGHTNESS%|$PROGRESS_BAR|"
