#!/usr/bin/env zsh

source $PWD/install/functions.sh

# install general packages
info_message "Installing general packages"
brew install curl wget gpg git unzip fontconfig

# install cli tools
info_message "Installing cli tools"
brew install vim fzf tmux htop
