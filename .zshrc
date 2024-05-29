#!/bin/zsh

# load .zsh directory
for file in ~/dotfiles/.zsh/*.zsh; do
  source $file
done

eval "$(sheldon source)"
