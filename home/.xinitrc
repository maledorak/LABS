#! /bin/bash

# set polish keyboard
setxkbmap pl

# run udiskie automounter for udisks2
udiskie --no-notify --tray --use-udisks2 &

# run redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

# run dropbox
/usr/bin/dropbox &

# run i3
exec i3
