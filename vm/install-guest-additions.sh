#!/bin/env bash

set -eou pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install build-essential dkms linux-headers-$(uname -r) -y

sudo mkdir /media/vboxga
sudo mount -o loop $HOME/VBoxGuestAdditions.iso /media/vboxga

sudo /media/vboxga/VBoxLinuxAdditions.run || true

if ! modinfo vboxsf &> /dev/null; then
  echo "Cannot find vbox kernel module. Installation of guest additions unsuccessful!"
  exit 1
fi

sudo adduser $USER vboxsf

sudo umount /media/vboxga
rm -rf $HOME/VBoxGuestAdditions.iso
