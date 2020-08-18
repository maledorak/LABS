#! /bin/bash

# Set default screenlayout
echo Setting default screen layout
case $(hostname) in
    "terminal")
    source /home/${USER}/.screenlayout/PC.sh
    ;;

    "myterminal")
    source /home/${USER}/.screenlayout/laptop-only.sh
    ;;

*)
    ;;
esac
