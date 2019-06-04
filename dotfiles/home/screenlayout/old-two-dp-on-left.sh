#!/bin/sh

# for tests, based on
# https://wiki.archlinux.org/index.php/Xrandr#Manage_2-monitors
./laptop-only.sh
#xrandr --newmode $(gtf 1920 1080 60.00 | tail -n 2 | head -n 2| cut -d'"' -f2- | tr -d '"')
#xrandr --newmode $(cvt 1920 1080 60.00 | tail -n 1 | cut -d' ' -f2- | tr -d '"')
#xrandr --rmmode 1920x1080_60.00
#xrandr --addmode DP-3 1920x1080_60.00
#xrandr --addmode DP-2 1920x1080_60.00

#xrandr 	--output DP-3 --mode 1920x1080_60.00 --pos 0x0 --rotate normal
#xrandr 	--output DP-2 --mode 1920x1080_60.00 --right-of DP-3 --rotate normal --primary
#xrandr --output LVDS-1 --mode 1600x900 --right-of DP-2 --rotate normal --mode 1920x1080_60.00

xrandr --fb 5440x1080 --output LVDS-1 --mode 1600x900 --pos 0x0 --rotate normal --crtc 0
xrandr --fb 5440x1080 --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --crtc 1
xrandr --fb 5440x1080 --output DP-3 --mode 1920x1080 --pos 0x0 --rotate normal --crtc 2
