#!/usr/bin/env bash
# Blocking sites on /etc/hosts

scripts_dir=$( cd ${0%/*} && pwd -P )
blocked_hosts_path=$scripts_dir/blocked_hosts
etc_hosts_md5=$(md5sum /etc/hosts | awk '{ print $1 }')
blocked_hosts_md5=$(md5sum $blocked_hosts_path | awk '{ print $1 }')
# This if statement is needed to don't override backup of original /etc/hosts
if [[ $etc_hosts_md5 != $blocked_hosts_md5 ]]; then
    echo 'Backuping /etc/hosts'
    if [[ -f /etc/hosts.bkp ]]; then
        # This is neede when blocked_hosts was already used,
        # but new domains was added meantime so md5 will be different.
        sudo mv -f /etc/hosts.bkp /etc/hosts
    fi
    sudo cp /etc/hosts /etc/hosts.bkp
    echo 'Copying blocing hosts'
    sudo cp -f $blocked_hosts_path /etc/hosts
    sudo chown root:root /etc/hosts
else
    echo '/etc/hosts is already with blocked domains'
fi
