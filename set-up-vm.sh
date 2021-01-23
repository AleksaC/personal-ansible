#!/usr/bin/env bash

set -eou pipefail

cd "$(dirname "$0")"

if ! vagrant box list | grep ubuntu-20.04 &> /dev/null; then
  if [ ! -f packer/ubuntu-20-04.box ]; then
    cd packer
    packer build ubuntu-20-04.json
    cd ..
  fi

  vagrant box add --name ubuntu-20.04 "file://$(readlink -f packer/ubuntu-20-04.box)"
  vagrant up
fi
