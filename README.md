# personal-ansible
[![license](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/AleksaC/personal-ansible/master.svg)](https://results.pre-commit.ci/latest/github/AleksaC/personal-ansible/master)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/AleksaC/personal-ansible/blob/master/.pre-commit-config.yaml)

Ansible playbooks for configuring my development environment.

## About

This repository contains ansible playbook for installing most of the programs I
use on my personal machine. I use Ubuntu 22.04, but most of the roles here should
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
ansible-playbook main.yml --tags role1,role2 -K
```

You should run these commands as the main user of the system in order to have all
the permissions and configurations properly set up.

To run this playbook I recommend setting up ansible inside a virtual environment
with the versions specified in `requirements.txt`. You can do this using
`set-up-venv.sh` script. Using other versions of ansible or methods of
installation is discouraged and may lead to errors.

### Testing
To test the playbooks from scratch in a virtualbox vm run the following commands:
```shell script
./vm/set-up-vm.sh
./vm/run-command.sh "/personal-ansible/run.sh"
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
