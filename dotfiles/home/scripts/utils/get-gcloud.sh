#!/bin/bash
# Get different version of kubectl and add it to /usr/local/bin/kubectl

ver=$1
if [ -z "$ver" ]
then
    echo "Set gcloud version as a first argument"
    echo "Check versions: https://cloud.google.com/sdk/docs/release-notes"
    exit 1
fi

gcloud_zip_path=${HOME}/.local/opt/google-cloud-cli-${ver}-linux-x86_64.tar.gz
gcloud_installation_path=${HOME}/.local/opt/google-cloud-cli

echo "Downloading gcloud in ${ver}"
curl -C -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${ver}-linux-x86_64.tar.gz -o ${gcloud_zip_path}

echo "Unpacking installation dir to ${gcloud_installation_path}"
tar xvf ${gcloud_zip_path} --one-top-level=${gcloud_installation_path} --strip-components 1

echo "Installation"
${gcloud_installation_path}/install.sh

