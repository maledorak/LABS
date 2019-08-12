#!/bin/sh
xrandr --fb 1600x900 --output LVDS-1 --primary --mode 1600x900 --pos 0x0 --rotate normal \
	--output DP-1 --off --output DP-2 --off --output DP-3 --off \
 	--output HDMI-1 --off  --output HDMI-2 --off --output HDMI-3 --off \
	--output VGA-1 --off
