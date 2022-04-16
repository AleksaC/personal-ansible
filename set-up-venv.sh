#!/usr/bin/env bash

set -eou pipefail

cd "$(dirname "$0")"

if [ -x venv/bin/ansible-playbook ]; then
  source venv/bin/activate
else
  vnv=virtualenv

  if ! command -v virtualenv > /dev/null; then
    sudo apt-get install -y python3-distutils
    if [ ! -f /tmp/virtualenv.pyz ]; then
      wget -O /tmp/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
    fi
    vnv="python3 /tmp/virtualenv.pyz"
  fi

  $vnv venv -p python3
  source ./venv/bin/activate

  sudo apt-get update
  # needed by psutil
  sudo apt-get install -y python3-dev

  pip install -r requirements.txt
fi
