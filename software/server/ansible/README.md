# Ansible

## Index

- [Ansible](#ansible)
  - [Index](#index)
  - [Roles](#roles)
    - [server-management](#server-management)
      - [Usage](#usage)
      - [tag tree](#tag-tree)
  - [Advices](#advices)
    - [docker-compose](#docker-compose)
      - [Usage](#usage-1)
      - [tag tree](#tag-tree-1)
      - [Advices](#advices-1)
  - [Bibliography](#bibliography)

## Roles

### server-management

#### Usage

First server configuration, groups, permissions and ssh access

#### tag tree

- **groups**: creates groups defined in vars/users_groups.yml
- **users**: creates users defined in vars/users_groups.yml
- **config_sudoers**: Make users passwordless for sudo in group wheel
- **ssh_copy**: copy the pub key for the final ansible user (default: ansible)
- **ssh_config**: securize ssh access config

## Advices

Be sure you have created the groups before create the users

### docker-compose

#### Usage

Install and manage docker compose
Also, manage all services that uses docker compose to work:

- frigate
- mosquitto

#### tag tree

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

#### Advices

Only call 1 service each time. If you want to manage frigate and mosquito, you must do 2 different executions. I'm not sure if the system will be stable if you call several services at same time

## Bibliography

Originally forked from <https://github.com/iMartzen/ansible-role-centos-docker-compose-setup/tree/master>

Mosquitto pass gen from: <https://shantanoo-desai.github.io/posts/technology/mosquitto_ansible_passgen/>
<https://industry40.systems/20>
