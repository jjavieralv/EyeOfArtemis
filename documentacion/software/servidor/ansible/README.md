# 1. Server ansible management

## 1.1. Index

- [1. Server ansible management](#1-server-ansible-management)
  - [1.1. Index](#11-index)
  - [1.2. First execution](#12-first-execution)
    - [1.2.1. Generate key pair](#121-generate-key-pair)
    - [1.2.2. First playbook to execute](#122-first-playbook-to-execute)
  - [1.3. Install docker-compose](#13-install-docker-compose)
  - [1.4. Install mosquitto](#14-install-mosquitto)
  - [1.5. Install frigate](#15-install-frigate)

## 1.2. First execution

### 1.2.1. Generate key pair

```shell
ssh-keygen -t ed25519 -f $HOME/.ssh/ansible -a 5000 -C "eyeofartemis ansible"
```

continue pressing enter without setting any pass to be passwordless

### 1.2.2. First playbook to execute

Copy the file ansible.pub(```shell echo $HOME/.ssh/ansible.pub``` ) to roles/server-management/files

This will config the server ready to continue using certs authentication instead of password.

```shell
ansible-playbook -i {your_inventory} -t first-execution,groups,users,config_sudoers,ssh_copy,ssh_config,energy -k --ask-become-pass server_management.yml
```

Now you can execute any other playbook

## 1.3. Install docker-compose

Config and install docker-compose

```shell
ansible-playbook -i inventories/test.yml -t docker-compose,prepare-system,install docker-compose_management.yml
```

## 1.4. Install mosquitto

First of all, on YOUR host machine (where you execute ansible) you need to install a python lib

```shell
sudo apt install python3-passlib
```

Or if you are doing your things right with an python env created

```shell
  {path_to_your_pip_in_environment} install passlib
```

Then, you are ready to install mosquitto

```shell
ansible-playbook -i inventories/test.yml -t mosquitto,config,up docker-compose_management.yml
```

Now you should have mosquitto working

## 1.5. Install frigate

```shell
ansible-playbook -i inventories/test.yml -t frigate,config,up docker-compose_management.yml
```
