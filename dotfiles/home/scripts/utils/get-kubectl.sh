#!/bin/bash
# Get different version of kubectl and add it to /usr/local/bin/kubectl

kube_ver=$1
if [ -z "$kube_ver" ]
then
    echo "Set below kubectl versions as a first argument:"
    curl -sL https://api.github.com/repos/kubernetes/kubernetes/releases | jq -r 'sort_by(.tag_name) | .[].tag_name'
    exit 1
fi

curl -LO https://storage.googleapis.com/kubernetes-release/release/${kube_ver}/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv -f ./kubectl /usr/local/bin/kubectl
kubectl version

