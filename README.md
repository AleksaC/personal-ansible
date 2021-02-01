# personal-ansible
[![license](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Build Status](https://travis-ci.org/AleksaC/personal-ansible.svg?branch=master)](https://travis-ci.org/AleksaC/personal-ansible)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/AleksaC/rsa/blob/master/.pre-commit-config.yaml)

Ansible playbooks for configuring my development environment.

## About

This repository contains ansible playbook for installing most of the programs I
use on my personal machine. I use Ubuntu 20.04, but most of the roles here should
work on other versions with little to no modification.

## Usage
To install everything with a single command:

```shell script
wget -O - "https://raw.githubusercontent.com/AleksaC/personal-ansible/master/run.sh" | bash
```

This will clone this repo to `/tmp` which means that it will get deleted at some
point. If you want to keep it around to use it for managing your configuration
after the initial run, you can specify destination for cloning like so:

```shell script
wget -O - "https://raw.githubusercontent.com/AleksaC/personal-ansible/master/run.sh" | bash -s .
```

If you want to set up ansible yourself and only run the playbook use:

```shell script
ansible-playbook main.yml -K
```

To only run certain roles use:

```shell script
ansible-playbook main.yml --tags role1 role2 -K
```

**Note**: For this purpose I've set up ansible in a virtual environment. It
turned out to be a bit tricky. To see how I've done it take a look at `set-up-venv.sh`.
I initially used ansible `2.9` and there were some changes in `2.10` which broke the
playbook so after fixing it I pinned the ansible version to either `2.9` or `2.10`
as I'm not sure if the playbook works on older versions and I'm not planning on
updating it for newer versions.

If you want to install ansbile through `apt` you need to change the
`interpreter_python` to a system interpreter in `ansible.cfg`. You also need to
install `psutil` as it is required by `dconf` tasks.

### Testing
To test the playbooks from scratch in a virtualbox vm run the following commands:
```shell script
./vm/set-up-vm.sh
./vm/run-command.sh 'wget -O - "https://raw.githubusercontent.com/AleksaC/personal-ansible/master/run.sh" | bash'
```
It will use packer and vagrant to provision a vm and run the command through ssh.
You can provide any command to `run-command.sh`. You can also provide `--recreate`
flag as a second argument to create a fresh vm.

You can also use `run-command.sh` to test changes since the repo directory is
available in the vm as synced folder at `/personal-ansible`.

## Contact
- [Personal website](https://aleksac.me)
- <a target="_blank" href="http://twitter.com/aleksa_c_"><img alt='Twitter followers' src="https://img.shields.io/twitter/follow/aleksa_c_.svg?style=social"></a>
- aleksacukovic1@gmail.com
