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

sudo apt-get update

if [ ! -t 0 ]; then
  dest="${1:-/tmp}"
  [[ "$dest" == */  ]] && dest="${dest::-1}"
  dest="$dest/personal-ansible"

  if ! command -v git > /dev/null; then
    sudo apt-get install -y git
  fi

  git clone https://github.com/AleksaC/personal-ansible "$dest"

  cd "$dest"
fi

if ! command -v ansible-playbook > /dev/null; then
  if [ -x venv/bin/ansible-playbook ]; then
    source venv/bin/activate
  else
    source set-up-venv.sh
  fi
fi

ansible-playbook main.yml $(sudo -n true &> /dev/null || echo -K)
