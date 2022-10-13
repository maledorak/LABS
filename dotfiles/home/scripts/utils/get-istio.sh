#!/bin/bash
# Get different version of istioctl
# based on: https://istio.io/latest/docs/setup/getting-started/#download

ISTIO_VERSION=$1
if [ -z "$ISTIO_VERSION" ]
then
    echo "Set below istio versions as a first argument:"
    curl -sL https://api.github.com/repos/istio/istio/releases | jq -r 'sort_by(.tag_name) | .[].tag_name'
    exit 1
fi

sudo rm -rf /usr/local/lib/istio
sudo mkdir -p /usr/local/lib/istio
curl -L https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-linux-amd64.tar.gz | \
    sudo tar -xz --strip-components=1 -C /usr/local/lib/istio
sudo chmod +rx /usr/local/lib/istio/bin
sudo ln -srf /usr/local/lib/istio/bin/istioctl /usr/local/bin/istioctl
echo "Istioctl version: $(istioctl version)"
