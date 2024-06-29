# Server software

## Index

- [Server software](#server-software)
  - [Index](#index)
  - [Ansible](#ansible)
  - [Install and config SO](#install-and-config-so)
    - [Ubuntu](#ubuntu)
      - [Create instalation device](#create-instalation-device)
      - [Install Ubuntu](#install-ubuntu)
      - [Config SO](#config-so)
        - [Create principal user](#create-principal-user)
        - [Update](#update)
        - [Network config](#network-config)
          - [Set static IP](#set-static-ip)
        - [Install openSSH](#install-openssh)
    - [Centos](#centos)
      - [Create instalation device](#create-instalation-device-1)
      - [Install Centos Stream 9](#install-centos-stream-9)
      - [Config SO](#config-so-1)
        - [Update](#update-1)
        - [Network config](#network-config-1)
          - [Set static IP](#set-static-ip-1)
  - [Hardware acceleration](#hardware-acceleration)
    - [FFMPEG](#ffmpeg)
      - [Description](#description)
      - [How to use](#how-to-use)

## Ansible

How to use the ansible technology to load the modules [here](./ansible/README.md)

## Install and config SO

### Ubuntu

#### Create instalation device

1. Download centos Ubuntu server iso [here](https://ubuntu.com/download/server)
2. Put iso file into an USB [guide](https://www.lifewire.com/how-to-burn-an-iso-file-to-a-usb-drive-2619270)
3. Connect the USB into the server and boot it

#### Install Ubuntu

1. Select install Ubuntu
2. Select the disk or partition you want to use
3. Set a strong root password and store it
4. Continue your installation

#### Config SO

##### Create principal user

1. Create a user called eyeofartemis. Use a strong credentials and store them

    ```shell
    adduser eyeofartemis
    ```

2. Add them sudo permissions

    ```shell
    usermod -aG sudo eyeofartemis
    ```

##### Update

1. Open a terminal and execute

```shell
sudo apt update
```

```shell
sudo apt upgrade -y
```

##### Network config

###### Set static IP

This is needed because it sets the path to find the server from outside

1. find your device name

    ```shell
    ip a
    ```

2. In case you are using wifi adapter

    ```shell
    sudo apt install wpasupplicant -y
    ```

3. In case you want to use your current network config
   1. Find your current device ip. You can use your current ip(use ```shell ip a``` to know
   2. Find your Gateway config. You can find it using ```shell route -n```
4. Set your static IP, Gateway and DNS. To do this, we will create a file on /etc/netplan/ that will be used as template. It MUST HAS .YAML extension


    ```shell
    sudo echo '
    network:
    version: 2
    renderer: networkd
    #if you are using ubuntu desktop probably you need to change renderer to
    #renderer: NetworkManager
    ethernets:
      {your_interface_name}:
        addresses:
          - {your_interface_ip}/{your_interface_mask}
        routes:
          - to: default
            via: {your_gateway_ip}
        nameservers:
            addresses: [{your_dns1_ip}, {your_dnsx_ip}]' >/etc/netplan/01-default.yaml
    ```

    Example

    ```shell
    sudo echo '
    network:
      version: 2
      renderer: networkd
      ethernets:
        enp2s0:
          addresses:
            - 192.168.1.30/24
          routes:
            - to: default
              via: 192.168.1.1
          nameservers:
              addresses: [1.1.1.1, 8.8.8.8, 4.4.4.4]' >/etc/netplan/01-default.yaml
    ```

    Example with eth and wifi as backup

    ```shell
    network:
    version: 2
    renderer: networkd
    ethernets:
      enp2s0:
        dhcp4: no
        addresses:
          - 192.168.1.30/24
        routes:
          - to: default
            via: 192.168.1.1
            metric: 100
        nameservers:
          addresses: [8.8.8.8, 8.8.4.4]
    wifis:
      wlxb0487a8d1bad:
        dhcp4: no
        access-points:
          "wifi_ssid":
            password: "********"
        addresses:
          - 192.168.1.30/24
        routes:
          - to: default
            via: 192.168.1.1
            metric: 200
        nameservers:
          addresses: [8.8.8.8, 8.8.4.4]
    ```

5. Apply your config

    ```shell
    sudo netplan apply
    ```

    Sometimes you neet to reboot here. Sometimes you must execute this command several times (I got error with Networkd service at first time)


6. Check iff the config has been updated correctly

    ```shell
    ip a    
    ```

##### Install openSSH

Just if you didnt added it during instalation process

```shell
sudo apt install openssh-server -y
```

### Centos

I strongly recommend you **NOT** to use it because there are hardware failures when you use CentOS

#### Create instalation device

1. Download centos Stream 9 iso [here](https://www.centos.org/download/)
2. Put iso file into an USB [guide](https://www.lifewire.com/how-to-burn-an-iso-file-to-a-usb-drive-2619270)
3. Connect the USB into the server and boot it

#### Install Centos Stream 9

1. Select install centos
2. Select the disk or partition you want to use
3. Set a strong root password and store it
4. Create a user called eyeofartemis
   1. with admin privileges
   2. Strong password that must be stored
5. Continue your installation

#### Config SO

##### Update

1. Open a terminal and execute

```shell
dnf check-update
```

```shell
sudo dnf update
```

In the second step you must write the user password to gain admin privileges

##### Network config

###### Set static IP

This is needed because it sets the path to find the server from outside

1. find your device name

    ```shell
    nmcli device
    ```

2. In case you want to use your current network config
   1. Find your current ip. You can use your current ip(use ```shell ip a``` to know
   2. Find your Gateway config. You can find it using ```shell route -n```
3. Set your static IP

    ```shell
    nmcli connection modify {your_device_name} ipv4.addresses {your_static_ip}/24
    ```

4. Change the IP management to manual

    ```shell
    nmcli connection modify {your_device_name} ipv4.method manual
    ```

5. Set the gateway IP

    ```shell
    nmcli connection modify {your_device_name} ipv4.gateway {your_gateway_ip}
    ```

6. Set up the DNS (optional)

    ```shell
    nmcli connection modify {your_device_name} ipv4.dns 8.8.8.8
    ```

7. Restart networkManager device

    ```shell
    nmcli connection down {your_device_name}
    ```

    ```shell
    nmcli connection up {your_device_name}
    ```

## Hardware acceleration

### FFMPEG

#### Description

Is the system that will enable hardware acceleration on video in order to improve the usage and free CPU

#### How to use

1. Install ffmpeg

    ```bash
    sudo snap install ffmpeg
    ```

2. List hardware acceleration available

  ``` shell
  ffmpeg -hwaccels
  ```
