#!/usr/bin/env bash
# Blocking websites on /etc/hosts

COMMAND=$1

BLOCK='block'
ALLOW='allow'
ALL_COMMANDS_ARRAY=($BLOCK $ALLOW)
ALL_COMMANDS_PIPED=$(IFS="|" ; echo "${ALL_COMMANDS_ARRAY[*]}")

if [[ $# -eq 0 ]] ; then
    echo "Using: ./$(basename $0) [$ALL_COMMANDS_PIPED]"
    exit 1
fi

if [[ ! "$COMMAND" =~ ^($ALL_COMMANDS_PIPED)$ ]]; then
    echo "You can use only [$ALL_COMMANDS_PIPED] as a first argument!"
    exit 1
fi

# dev purpose
# hosts_to_block="$(dirname "${0}")/hosts-blocker-conf"

hosts_to_block="${XDG_CONFIG_HOME}/hosts-blocker-conf"

if [ ! -f "${hosts_to_block}" ]; then
    echo "File '${hosts_to_block}' not found!"
    exit 1
fi

if [[ "$COMMAND" = "$BLOCK" ]]; then
  echo "Blocking below hosts:"
    cat ${hosts_to_block}
    echo '-----'
    cat ${hosts_to_block} | while read line || [[ -n $line ]];
    do
        record="127.0.0.1  ${line}  # AUTOCREATED by hosts-blocker"
        if ! grep -q "${record}" "/etc/hosts"; then
            echo "No record $line - adding"
            echo "${record}" | sudo tee -a /etc/hosts > /dev/null
        else
            echo "Record $line exists - skipping"
        fi
    done
fi

if [[ "$COMMAND" = "$ALLOW" ]]; then
  echo "Unblocking /etc/hosts"
    sudo sed -i "/AUTOCREATED by hosts-blocker/d" /etc/hosts
fi


