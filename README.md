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
If you want to set up ansible yourself and only run the playbook use:
```shell script
ansible-playbook main.yml -K
```
To only run certain roles use:
```shell script
ansible-playbook main.yml --tags role1 role2 -K
```

**Note**: For this purpose I've set up ansible in a virtual environment. It
turned out to be a bit tricky. To see how I've done it take a look at `run.sh`.
If you want to install ansbile through `apt` you need to change the
`interpreter_python` to a system interpreter in `ansible.cfg`. You also need to
install `psutil` as it is for some reason  required by `dconf` tasks.

## Contact
- [Personal website](https://aleksac.me)
- <a target="_blank" href="http://twitter.com/aleksa_c_"><img alt='Twitter followers' src="https://img.shields.io/twitter/follow/aleksa_c_.svg?style=social"></a>
- aleksacukovic1@gmail.com
