#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
# based on: https://github.com/polybar/polybar/issues/763
  primary=$(xrandr --query | grep "primary" | cut -d" " -f1)
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ $m = $primary ]; then
      tray=right
    else
      tray=
    fi
    MONITOR=$m TRAY_POSITION=$tray polybar --reload main_bar &
  done
else
  echo "Install xrandr to use multimonitor setup"
  MONITOR=LVDS-1 TRAY_POSITION=right polybar --reload main_bar &
fi

echo "Polybars launched..."
