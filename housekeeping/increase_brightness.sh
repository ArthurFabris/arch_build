#!/bin/bash

# Increase brightness by 5%
xbacklight -inc 10

# Get the current brightness
BRIGHTNESS=$(xbacklight -get | cut -d '.' -f 1)
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
dunstify -r 9992 -u low -i /home/arthur/housekeeping/increase_icon.png "$BRIGHTNESS%|$PROGRESS_BAR|"

