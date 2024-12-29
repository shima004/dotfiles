#!/usr/bin/env zsh

source $PWD/install/functions.sh

function install_packages() {
  if command -v brew >/dev/null 2>&1; then
    $PWD/install/brew.sh
    success_message "Installed brew packages"
  elif command -v apt >/dev/null 2>&1; then
    $PWD/install/apt.sh
    success_message "Installed apt packages"
  fi
}

function install_starship() {
  if ! command -v starship >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://starship.rs/install.sh | sh -s -- -y
    success_message "Installed starship"
  else
    info_message "Already installed starship"
  fi
}

function install_sheldon() {
  if ! command -v sheldon >/dev/null 2>&1; then
    if command -v brew >/dev/null 2>&1; then
      brew install sheldon
    else
      curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin
    fi
    success_message "Installed sheldon"
  else
    info_message "Already installed sheldon"
  fi
}

function install_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    curl https://mise.run | sh
    success_message "Installed mise"
  else
    info_message "Already installed mise"
  fi
}

function install_font(){
  local readonly font_version="v1.0.2"
  if [[ ! -d "$HOME/.fonts/MoralerspaceNF_$font_version" ]]; then
    mkdir -p $HOME/.fonts
    curl -L https://github.com/yuru7/moralerspace/releases/download/$font_version/MoralerspaceNF_$font_version.zip -o /tmp/MoralerspaceNF.zip
    unzip -o /tmp/MoralerspaceNF.zip -d $HOME/.fonts
    rm -f /tmp/MoralerspaceNF.zip
    fc-cache -f -v
    success_message "Installed MoralerspaceNF font"
  else
    info_message "Already installed MoralerspaceNF font"
  fi
}

install_packages
install_sheldon
install_starship
install_mise
install_font

# $1: package name
# $2: command name
function install_by_cargo() {
  local -r package=$1
  local -r command=${2:-$1}
  if ! command -v cargo >/dev/null 2>&1; then
    error_message "Please install cargo"
    exit 1
  fi
  if ! command -v $command >/dev/null 2>&1; then
    if ! cargo install $package; then
      error_message "Failed to install $package"
    else
      success_message "Installed $package"
    fi
  else
    info_message "Already installed $package"
  fi
}

source $HOME/.zshrc

mise i --yes

install_by_cargo lsd
install_by_cargo bat
install_by_cargo ripgrep rg
