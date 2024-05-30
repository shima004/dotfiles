#!/bin/bash

# update and upgrade the package list
apt-get update -y && apt-get upgrade -y

# install zsh
apt-get install zsh -y

# install packages
apt-get install curl wget gpg git unzip fontconfig -y

# install cli tools
apt-get install ripgrep bat -y
