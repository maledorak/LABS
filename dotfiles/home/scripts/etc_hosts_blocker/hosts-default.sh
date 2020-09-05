#!/usr/bin/env bash

scripts_dir=$( cd ${0%/*} && pwd -P )

if [[ -f /etc/hosts.bkp ]]; then
    etc_hosts_md5=$(md5sum /etc/hosts | awk '{ print $1 }')
    etc_hosts_bkp_md5=$(md5sum /etc/hosts.bkp | awk '{ print $1 }')
    if [[ $etc_hosts_md5 != $etc_hosts_bkp_md5 ]]; then
        sudo mv -f /etc/hosts.bkp /etc/hosts
        echo 'Reverting /etc/hosts from backup'
    else
        echo 'md5 of /etc/hosts and its backup is the same'
    fi
else
    echo 'There is no /etc/hosts.bkp'
fi
