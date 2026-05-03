{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    shellAliases = {
      ls = "lsd";
      ll = "lsd -la";
      cat = "bat";
      k = "kubectl";
      tmux = "zellij";
      gcd = "cd $(ghq list --full-path | fzf)";
      gcv = "code $(ghq list --full-path | fzf)";
    };
    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    initContent = ''
      setopt INC_APPEND_HISTORY
      setopt HIST_REDUCE_BLANKS

      # Bitwarden SSH Agent bridge (WSLのみ)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
        if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
          rm -f "$SSH_AUTH_SOCK"
          ( setsid socat \
            UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" \
            EXEC:"/mnt/c/ProgramData/chocolatey/lib/npiperelay/tools/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent" \
            & )
        fi
      fi
    '';
  };
}
