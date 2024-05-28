#!/bin/bash

# Function to check battery level
check_battery_level() {
    battery_level=$(cat /sys/class/power_supply/BAT1/capacity)

    # Determine the message based on battery level
    if [ $battery_level -ge 100 ]; then
        echo "󰁹$battery_level"

    elif [ $battery_level -ge 90 ]; then
        echo -n "󰂂$battery_level"
    elif [ $battery_level -ge 80 ]; then
        echo -n "󰂁$battery_level"
    elif [ $battery_level -ge 70 ]; then
        echo -n "󰂀$battery_level"
    elif [ $battery_level -ge 60 ]; then
        echo -n "󰁿$battery_level"
    elif [ $battery_level -ge 50 ]; then
        echo -n "󰁾$battery_level"
    elif [ $battery_level -ge 40 ]; then
        echo -n "󰁽$battery_level"
    elif [ $battery_level -ge 30 ]; then
        echo -n "󰁼$battery_level"
    elif [ $battery_level -ge 20 ]; then
        echo -n "󰁻$battery_level"
    elif [ $battery_level -ge 10 ]; then
        echo -n "󰁺$battery_level"
    else
        echo -n "󰂎$battery_level"
    fi
}
# Function to check battery status
check_battery_status() {
    battery_status=$(cat /sys/class/power_supply/BAT1/status)

    case $battery_status in
        "Charging")
            echo -n "󱐌"
            ;;
        "Full")
            echo -n "󱐋"
            ;;
        "Discharging")
            echo -n ""
            ;;
        *)
            echo -n "??"
            ;;
    esac
}

get_timezone_offset() {
    current_date=$(date +"%A |%d/%m/%Y| %H:%M")
    echo -n "$current_date"
}

check_internet_connection() {
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        echo ""
    else
        echo ""
    fi
}
# Function to check RAM usage
check_ram_usage() {
    # Get memory usage details
    mem_info=$(free | grep Mem)

    # Extract total and used memory values
    total_mem=$(echo $mem_info | awk '{print $2}')
    used_mem=$(echo $mem_info | awk '{print $3}')

    # Calculate percentage of used memory using awk
    mem_usage_percent=$(awk "BEGIN {printf \"%.2f\", $used_mem / $total_mem * 100}")
    mb_ram=$(free --mega | grep "Mem.:" | awk '{print $3}')

    # Print the result
    echo "$mem_usage_percent%  $mb_ram mb"
}


cpu_usage(){


    cpu_usg=$(mpstat | grep all |tr "," "."| awk '{print 100.0-$12}')
    echo $cpu_usg
}

cpu_temp() {
    echo "$(sensors | grep "Package id 0" | grep -o '[+-.0-9]*°C' | sed 's/+//' | head -n 1)"
}

# Function to set root window name with battery info
set_root_window_name() {
	battery_info=" $(check_ram_usage) | $(cpu_usage)% | $(cpu_temp) | $(get_timezone_offset) | $(check_battery_status) $(check_battery_level) | $(check_internet_connection) "
    xsetroot -name "$battery_info"
}

# Call the function to set root window name with battery inf
while true; do
    set_root_window_name
    sleep 1
done

