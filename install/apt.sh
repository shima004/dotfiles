#!/bin/bash

# update and upgrade the package list
apt-get update -y && apt-get upgrade -y

# install packages
apt-get install curl wget gpg git unzip fontconfig build-essential -y

# install tzdata
DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# install cli tools
apt-get install vim -y
