#!/usr/bin/env bash

set -eou pipefail

# Temporarily disable unattended upgrades so they don't acquire dpkg lock between ansible tasks
old_config=$(< /etc/apt/apt.conf.d/20auto-upgrades)

restore_config() {
  echo "$old_config" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null
}

trap restore_config EXIT
trap restore_config ERR

sudo sed -i 's/1/0/g' /etc/apt/apt.conf.d/20auto-upgrades

if [ ! -t 0 ]; then
  dest="${1:-/tmp}"
  [[ "$dest" == */  ]] && dest="${dest::-1}"
  dest="$dest/personal-ansible"

  if ! command -v git > /dev/null; then
    sudo apt-get update
    sudo apt-get install -y git
  fi

  git clone https://github.com/AleksaC/personal-ansible "$dest"

  cd "$dest"
else
  cd "$(dirname "$0")"
fi

source set-up-venv.sh

ansible-playbook main.yml $(sudo -n true &> /dev/null || echo -K)
