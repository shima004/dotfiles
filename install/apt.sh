#!/usr/bin/env zsh

source $PWD/install/functions.sh

# install build dependencies
info_message "Installing build dependencies"
sudo apt-get install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev -y

# install general packages
info_message "Installing general packages"
sudo apt-get install curl wget gpg git unzip fontconfig -y

# install tzdata
info_message "Installing tzdata"
DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo sudo apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# install cli tools
info_message "Installing cli tools"
sudo apt-get install vim fzf tmux htop -y
