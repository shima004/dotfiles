#!/usr/bin/env zsh

source $PWD/install/functions.sh

# install general packages
info_message "Installing general packages"
apt-get install curl wget gpg git unzip fontconfig build-essential -y

# install tzdata
info_message "Installing tzdata"
DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get install -y tzdata && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# install cli tools
info_message "Installing cli tools"
apt-get install vim fzf tmux htop -y
