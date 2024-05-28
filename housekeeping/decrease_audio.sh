#!/bin/bash

# Decrease the volume by 5%
pamixer --decrease 5

# Get current volume level
VOLUME=$(pamixer --get-volume)

# Calculate the number of '#' characters for the progress bar (assuming maximum volume is 100)
NUM_HASHES=$(( (VOLUME * 20 / 100) + 1))

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

# Show notification with the volume progress bar
dunstify -r 9991 -u low -i /home/arthur/housekeeping/audio_icon.png "$VOLUME%|$PROGRESS_BAR|"
