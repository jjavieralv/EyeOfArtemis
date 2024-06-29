# 1. EyeOfArtemis Ansible

## 1.1. Index

- [1. EyeOfArtemis Ansible](#1-eyeofartemis-ansible)
  - [1.1. Index](#11-index)
  - [1.2. Roles](#12-roles)
    - [1.2.1. server-management](#121-server-management)
      - [1.2.1.1. Description](#1211-description)
      - [1.2.1.2. Requeriments](#1212-requeriments)
      - [1.2.1.3. Advices](#1213-advices)
      - [1.2.1.4. Dependencies](#1214-dependencies)
      - [1.2.1.5. Tag tree](#1215-tag-tree)
    - [1.2.2. docker-compose](#122-docker-compose)
      - [1.2.2.1. Description](#1221-description)
      - [1.2.2.2. Requeriments](#1222-requeriments)
      - [1.2.2.3. Advices](#1223-advices)
      - [1.2.2.4. Dependencies](#1224-dependencies)
      - [1.2.2.5. Tag tree](#1225-tag-tree)
  - [1.3. Bibliography](#13-bibliography)
  - [1.4. Author Information](#14-author-information)

## 1.2. Roles

### 1.2.1. server-management

#### 1.2.1.1. Description

First server configuration, groups, permissions and ssh access

#### 1.2.1.2. Requeriments

Ubuntu based distribution on server-side

#### 1.2.1.3. Advices

Be sure you have created the groups before create the users

#### 1.2.1.4. Dependencies

A user created called eyeofartemis with sudo permissions. This will be used on the first interaction in order to create the management users and copy their ssh-certificates to be able to stablish secure connection while executing other playbooks. That is why on the first execution you must use

```shell
ansible-playbook -i {your_inventory} -t first-execution,groups,users,config_sudoers,ssh_copy,ssh_config -k --ask-become-pass server_management.yml
```

#### 1.2.1.5. Tag tree

- **first-execution**: first execution that enable you to use ansible user on following executions
- **groups**: creates groups defined in vars/users_groups.yml
- **users**: creates users defined in vars/users_groups.yml
- **config_sudoers**: Make users passwordless for sudo in group wheel
- **ssh_copy**: copy the pub key for the final ansible user (default: ansible)
- **ssh_config**: securize ssh access config
- **energy**: set up energy plan

### 1.2.2. docker-compose

#### 1.2.2.1. Description

Install and manage docker compose
Also, manage all services that uses docker compose to run EyeOfArtemis:

- frigate
- mosquitto

#### 1.2.2.2. Requeriments

Ubuntu based distribution on server-side

#### 1.2.2.3. Advices

Only call 1 service each time. If you want to manage frigate and mosquito, you must do 2 different executions. I'm not sure if the system will be stable if you call several services at same time

#### 1.2.2.4. Dependencies

The host must have installed a python lubrary called passlib

```shell
sudo apt install python3-passlib
```

Or if you are doing your things right with an python env created

```shell
  {path_to_your_pip_in_environment} install passlib
```

#### 1.2.2.5. Tag tree

Tags to manage this role:

- **docker-compose**: install docker compose itself
  - **prepare-system**: first tag set up system to install later
  - **install**: install all necesary tools to run docker-compose
- **frigate**: manage frigate service infra
  - **config**: set up frigate config
  - **delete**: remove all frigate configs
  - **up**: Start service
  - **down**: Stop service
  - **restart**: Restart service
- **mosquitto**: manage mosquito service infra
  - **config**: set up mosquitto config
  - **delete**: remove all mosquitto configs
  - **up**: Start service
  - **down**: Stop service
  - **restart**: Restart service


## 1.3. Bibliography

Originally forked from <https://github.com/iMartzen/ansible-role-centos-docker-compose-setup/tree/master>

Mosquitto pass gen from: <https://shantanoo-desai.github.io/posts/technology/mosquitto_ansible_passgen/>
<https://industry40.systems/20>

## 1.4. Author Information

Created by jjavieralv