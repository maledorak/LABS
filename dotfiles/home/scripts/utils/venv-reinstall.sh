#!/bin/zsh

NAME=$1

if [ -z "$NAME" ]; then
    echo "Usage: $0 <venv-name>"
    exit 1
fi

if [ ! -d "$VIRTUALENVWRAPPER_HOOK_DIR/$NAME" ]; then
    echo "Virtualenv '$NAME' does not exist"
    exit 1
fi

echo "Reinstalling '$NAME'"

source virtualenvwrapper_lazy.sh
if [ ! -z "$VIRTUAL_ENV" ]; then
    deactivate
fi

rmvirtualenv $NAME
mv $PROJECT_HOME/$NAME $PROJECT_HOME/$NAME.bak
mkproject $NAME
rm -rf $PROJECT_HOME/$NAME
mv $PROJECT_HOME/$NAME.bak $PROJECT_HOME/$NAME
workon $NAME
