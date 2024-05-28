#!/bin/bash

#Set keyboard layout
setxkbmap -layout br -variant abnt2 &

# Background image
/home/arthur/.fehbg &

# Status bar
/home/arthur/housekeeping/status_bar_cfg.sh &

# Battery manager
/home/arthur/housekeeping/battery_mgr.sh &

#Print Screen daemon
exec flameshot &

#Key bindings daemon
xbindkeys &

# Notifications daemon
dunst &

# Window manager
exec dwm
