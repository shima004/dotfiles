#!/usr/bin/env bash

function info_message(){
  echo -e "\e[36m$1\e[m\n"
} 

function check_pkg_manager() {
  if command -v brew >/dev/null 2>&1; then
    echo -e "\e[36mVerified package manager: $(brew --version)\e[m\n"
  elif command -v apt >/dev/null 2>&1; then
    echo -e "\e[36mVerified package manager: $(apt --version)\e[m\n"
    apt-get update -y && apt-get upgrade -y
    apt-get update 
  else
    info_message "No supported package manager found. Please install apt or brew."
    exit 1
  fi
}

function create_symlinks() {
  # create simbolic links to the dotfiles in the home directory
  for file in .zshrc .zshenv; do
    ln -sf $PWD/$file ~/$file
  done

  # create simbolic links to the dotfiles in the .zsh directory
  for file in .zsh .config; do
    ln -sf $PWD/$file ~/$file
  done
  # create simbolic links to the vscode settings
  os=$(uname)
  if [[ "$os" == "Darwin" ]]; then
    ln -sf $HOME/.config/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
    ln -sf $HOME/.config/Code/User/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
  fi
  info_message "Created symbolic links"
}

function install_zsh() {
  if ! command -v zsh >/dev/null 2>&1; then
    if command -v brew >/dev/null 2>&1; then
      brew install zsh
    elif command -v apt >/dev/null 2>&1; then
      apt-get install zsh -y
    else
      info_message "No supported package manager found. Please install apt or brew."
      exit 1
    fi
    # change the default shell to zsh
    chsh -s $(which zsh)
    info_message "Installed zsh"
  else
    info_message "Already installed zsh"
  fi
}

# check if the package manager is installed
check_pkg_manager

# create the symbolic links
create_symlinks

# install zsh
install_zsh

# run the install script
$PWD/install/install.sh
