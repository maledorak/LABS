#
# ~/.bash_logout
#
# v0.0.1
# updated: 24.02.2018
#

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# virtualenvwrapper config
[ "$VIRTUAL_ENV" ] && deactivate

