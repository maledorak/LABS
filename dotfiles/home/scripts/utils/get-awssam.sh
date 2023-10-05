#!/bin/bash

AWS_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"

function install_sam {
    curl -L "${AWS_URL}" -o "/tmp/aws-sam.zip"
    unzip /tmp/aws-sam.zip -d /tmp/sam-installation
    sudo /tmp/sam-installation/install $1
    rm -rf /tmp/aws-sam.zip /tmp/sam-installation
    exit 0
}

if [ -f "/usr/local/bin/sam" ]; then
    echo "Aws sam is already installed"

    INSTALLED_VERSION=$(sam --version | awk '{print $4}')
    LATEST_VERSIONS=$(curl -s https://api.github.com/repos/aws/aws-sam-cli/releases | jq -r '.[] | .tag_name' | sort -V | tail -n 1 | sed 's/v//g')

    echo "Installed version: ${INSTALLED_VERSION}"
    echo "Latest versions: ${LATEST_VERSIONS}"

    if [ "${INSTALLED_VERSION}" == "${LATEST_VERSION}" ]; then
        echo "AWS Sam is already the latest version ${INSTALLED_VERSION}"
        exit 0
    fi

    echo "Update AWS Sam ${INSTALLED_VERSION} to ${LATEST_VERSION}"
    install_sam --update

else
    echo "Install AWS Sam"
    install_sam
fi
