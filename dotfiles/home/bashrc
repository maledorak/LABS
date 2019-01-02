#
# ~/.bashrc
#
# v0.0.1
# updated: 24.02.2018
#

# Enable vim mode in bash with <ESCAPE> key.
set -o vi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Alias definitions
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# bash-completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    ssh-add
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# virtualenvwrapper
export WORKON_HOME=$HOME/code/venvs
export PROJECT_HOME=$HOME/code/projects
source /usr/bin/virtualenvwrapper.sh

# Powerline for ubuntu
#if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
#    source /usr/share/powerline/bindings/bash/powerline.sh
#fi

# Powerline for arch
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
if [ -f /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
fi

source /home/mariusz/opt/venvsetup/venvsetup.sh
