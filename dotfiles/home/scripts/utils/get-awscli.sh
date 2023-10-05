#!/bin/bash

AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"

function install_aws {
    curl -L "${AWS_URL}" -o "/tmp/awscliv2.zip"
    unzip /tmp/awscliv2.zip -d /tmp
    sudo /tmp/aws/install $1
    rm -rf /tmp/awscliv2.zip /tmp/aws
    aws --version
    exit 0
}

if [ -d "/usr/local/aws-cli" ]; then
    echo "Awscli is already installed"

    INSTALLED_VERSION=$(aws --version | awk '{print $1}' | awk -F/ '{print $2}')
    LATEST_VERSION=$(curl -s https://api.github.com/repos/aws/aws-cli/tags | jq -r '.[] | .name' | sort -V | tail -n 1)

    if [ "${INSTALLED_VERSION}" == "${LATEST_VERSION}" ]; then
        echo "Awscli is already the latest version ${INSTALLED_VERSION}"
        exit 0
    fi
    echo "Update awscli ${INSTALLED_VERSION} to ${LATEST_VERSION}"
    install_aws --update
    exit 0
else
    echo "Install awscli"
    install_aws
    exit 0
fi
