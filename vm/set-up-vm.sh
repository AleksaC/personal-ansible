#!/usr/bin/env bash

set -eou pipefail

cd "$(dirname "$0")"

if ! vagrant box list | grep ubuntu-20.04 &> /dev/null; then
  if [ ! -f ubuntu-20-04.box ]; then
    packer build ubuntu-20-04.json
  fi

  vagrant box add --name ubuntu-20.04 "file://$(readlink -f ubuntu-20-04.box)"
fi

vagrant up
