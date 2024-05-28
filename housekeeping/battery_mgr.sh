#!/bin/bash

# Function to check the battery percentage
check_battery() {
    battery_level=$(cat /sys/class/power_supply/BAT1/capacity)
    echo $battery_level
}

while true; do

    if [ "$battery_level" -le 5 ]; then
        dunstify -r 9999 -u critical "Battery Low" "Battery at $(check_battery)%. Shutting down in 60 seconds."
        sleep 60
        shutdown -h now

    elif [ "$battery_level" -le 15 ]; then
        dunstify -r 9998 -u normal "Battery Warning" "Battery at $(check_battery)%. Please plug in your charger."
        # Sleep for 14 seconds before checking again
        sleep 15

    else
        # Sleep for 2 minutes before checking again
        sleep 120
    fi

    done


