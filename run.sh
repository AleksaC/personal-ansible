#!/usr/bin/env bash

set -eou pipefail

# Temporarily disable unattended upgrades so they don't acquire dpkg lock between ansible tasks
old_config=$(< /etc/apt/apt.conf.d/20auto-upgrades)
sudo sed -i 's/1/0/g' /etc/apt/apt.conf.d/20auto-upgrades

restore_config() {
  echo "$old_config" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades > /dev/null
}

trap restore_config EXIT
trap restore_config ERR

sudo apt update

if [ ! -t 0 ]; then
  if ! command -v git > /dev/null; then
    sudo apt install -y git
  fi

  git clone https://github.com/AleksaC/personal-ansible /tmp/personal-ansible

  cd /tmp/personal-ansible
fi

if ! command -v ansible-playbook > /dev/null; then
  sudo apt install -y build-essential python3-virtualenv python3-dev

  virtualenv venv -p python3
  source ./venv/bin/activate

  pip install wheel
  pip install psutil ansible

  # python-apt is required to use apt module; seems like it cannot be installed through pip
  # this probably only works on ubuntu 20
  mkdir py-apt
  sudo chown _apt py-apt

  cd py-apt

  sudo apt download python3-apt=2.0.0
  dpkg -x python3-apt_2.0.0_amd64.deb python-apt
  cp -r ./python-apt/usr/lib/python3/dist-packages/* ../venv/lib/python3.8/site-packages/

  cd ..
fi

ansible-playbook main.yml -K
