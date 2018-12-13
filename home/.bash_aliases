#
# ~/.bash_aliases
#
# v0.0.5
# updated: 24.02.2018
#

#Generic shortcuts:
alias music="ncmpcpp"
alias clock="ncmpcpp -s clock"
alias visualizer="ncmpcpp -s visualizer"
alias files="ranger"
alias audio="ncpamixer"

# System Maintainence
alias progs="pacman -Qet" # List programs I've installed
alias orphans="pacman -Qdt" # List orphan programs
alias upgr="neofetch && sudo pacman -Syyu --noconfirm && echo Update complete. | figlet"
alias plltime="sudo timedatectl set-timezone Europe/Warsaw && i3 restart" # Eastcoast time
alias sdn="sudo shutdown now"
alias newnet="sudo systemctl restart NetworkManager" # Refresh wifi
alias sctl="sudo systemctl"
alias sctlr="sudo systemctl restart"
alias sctls="sudo systemctl status"
alias sctlr="sudo systemctl start"
alias sctlh="sudo systemctl stop"
alias archservers="sudo reflector --country Germany --country Poland --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist"

# Some aliases
alias ssh="assh wrapper ssh"
alias p="sudo pacman"
alias v="vim"
alias sv="sudo vim"
alias rr="ranger"
alias sr="sudo ranger"
alias ka="killall"
alias g="git"
alias s='git status'
alias gitup="git push origin master"
alias gitpass="git config --global credential.helper cache"
alias gitb="git branch | grep \* | cut -d ' ' -f2"
alias tr="transmission-remote"
alias mkd="mkdir -pv"
alias rf="source ~/.bashrc"
alias ref="~/.config/Scripts/shortcuts.sh && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias bars="bash ~/.config/polybar/launch.sh" # Run Polybar relaunch script
alias bw="wal -i ~/.config/wall.png" # Rerun pywal
alias envg="env | grep "
alias i="invoke"
alias il="invoke --list"
alias ntruf="node_modules/.bin/truffle"

# Adding color
alias ls='ls -hNF --color --group-directories-first'
alias la='ls -hFAN --color --group-directories-first'
alias ll='ls -hlFAN --color --group-directories-first'
alias lll='ls -hlFAN --color --group-directories-first | less -R'
alias grep="grep --color=always" # Color grep - highlight desired sequence.
alias ccat="highlight --out-format=xterm256" #Color cat - print file with syntax highlighting.

# Laptop management
alias lsc="screen.sh l" # Use laptop screen only
alias vsc="screen.sh v" # Use VGA only
alias dsc="screen.sh d" # Use both laptop and VGA screen
alias debase="sudo umount /home/Shared/Videos & screen.sh l && i3 restart" # Prep for taking my ThinkPad off Ultrabase

# Internet
alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="youtube-dl --add-metadata -xic" # Download only audio
alias YT="youtube-viewer"
alias ethspeed="speedometer -r enp0s25"
alias wifispeed="speedometer -r wlp3s0"

# Git
alias g='git'
alias s='git status'
alias gitc='git commit'
alias gitp='git push -u'
alias gitcem='git checkout master'
alias gitcel='git checkout -'
alias gits='git stash'
alias gitsa='git stash apply'
alias gitwip='git add . && git commit -m "wip"'
alias gitunwip='git reset HEAD~1'
alias gitcmpcl='git checkout master && git pull && git checkout -'

# ElasticSearch
alias elastic='sudo /etc/init.d/elasticsearch'

# Python/Django
alias ser='./manage.py runserver 127.0.0.1:8000'
alias ser1='./manage.py runserver 127.0.0.1:8001'
alias ser2='./manage.py runserver 127.0.0.1:8002'
alias ser3='./manage.py runserver 127.0.0.1:8003'
alias ser0='./manage.py runserver 0.0.0.0:8000'
alias serkill='fuser -k 8000/tcp'
djt() {
    test_path="$@"
    if [ test_path ]; then
        fixed_test_path=${test_path//[#]/.}
        ./manage.py test -n $fixed_test_path
    else
        ./manage.py test -n
    fi
}
alias dsu='./manage.py createsuperuser'
alias dsp='./manage.py shell_plus'
alias add2virtualenv_edit='cdvirtualenv && vim lib/python2.7/site-packages/_virtualenv_path_extensions.pth'

# Files
alias edit_alias='vim ~/.bash_aliases'
alias show_alias='cat ~/.bash_aliases'
alias edit_ssh='vim ~/.ssh/assh.yml'
