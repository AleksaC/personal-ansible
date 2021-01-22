#!/usr/bin/env bash

sudo apt-get update

vnv=virtualenv

if ! command -v virtualenv > /dev/null; then
  sudo apt-get install python3-distutils
  wget -O /tmp/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
  vnv="python3 /tmp/virtualenv.pyz"
fi

$vnv venv -p python3
source ./venv/bin/activate

mkdir py-apt
sudo chown _apt py-apt

cd py-apt

sudo apt-get download python3-apt
dpkg -x python3-apt_*.deb python-apt
cp -r ./python-apt/usr/lib/python3/dist-packages/* ../venv/lib/python3.8/site-packages/

cd ..

rm -rf py-apt

pip install wheel psutil "ansible>=2.9<2.11"
