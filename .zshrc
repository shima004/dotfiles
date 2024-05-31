#!/usr/bin/env zsh

# load .zsh directory
for file in ~/.zsh/*.zsh; do
  source $file
done

# setting zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY

if command -v sheldon >/dev/null 2>&1; then
  eval "$(sheldon source)"
fi
