#!/bin/bash

# # create simbolic links to the dotfiles in the home directory
# for file in .zshrc .zshenv; do
#   ln -s $PWD/$file ~/$file
# done

# # run $HOME/dotfiles/.zsh/apt.zsh
# $HOME/dotfiles/.zsh/apt.zsh

# # install sheldon
# curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
#     | bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin


# # change the default shell to zsh
# chsh -s $(which zsh)

# # restart the shell
# exec zsh

function check_pkg_manager() {
    if command -v brew >/dev/null 2>&1; then
        echo -e "\e[36mVerified package manager: $(brew --version)\e[m\n"
    elif command -v apt >/dev/null 2>&1; then
        echo -e "\e[36mVerified package manager: $(apt --version)\e[m\n"
        apt-get update -y && apt-get upgrade -y
        apt-get update 
    else
        echo -e "\e[31m No supported package manager found. Please install apt or brew. \e[0m"
        exit 1
    fi
}

function install_font(){
  if [ ! -d "$HOME/.fonts/MoralerspaceNeonNF-Regular.ttf" ]; then
    mkdir -p $HOME/.fonts
    curl -L https://github.com/yuru7/moralerspace/releases/download/v1.0.0/MoralerspaceHW_v1.0.0.zip -o /tmp/MoralerspaceHW_v1.0.0.zip
    unzip /tmp/MoralerspaceHW_v1.0.0.zip -d $HOME/.fonts
    rm -f /tmp/MoralerspaceHW_v1.0.0.zip
    fc-cache -f -v
    echo -e "\e[36mInstalled MoralerspaceHW font\e[m\n"
  fi
}

function install_packages() {
    if command -v brew >/dev/null 2>&1; then
        .zsh/brew.zsh
    elif command -v apt >/dev/null 2>&1; then
        .zsh/apt.zsh
    fi
}

function install_starship() {
    if ! command -v starship >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://starship.rs/install.sh | sh -s -- -y
        echo -e "\e[36mInstalled starship\e[m\n"
    fi
}

function install_sheldon() {
    if ! command -v sheldon >/dev/null 2>&1; then
        curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin
        echo -e "\e[36mInstalled sheldon\e[m\n"
    fi
}

function create_symlinks() {
    # create simbolic links to the dotfiles in the home directory
    for file in .zshrc .zshenv; do
        ln -s $PWD/$file ~/$file
    done

    # create simbolic links to the dotfiles in the .zsh directory
    for file in .zsh .config; do
        ln -s $PWD/$file ~/$file
    done
}

check_pkg_manager
create_symlinks
install_packages
install_sheldon
install_starship
install_font
