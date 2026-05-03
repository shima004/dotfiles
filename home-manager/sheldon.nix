{ config, pkgs, ... }:

{
  programs.sheldon = {
    enable = true;
    settings = {
      shell = "zsh";
      plugins = {
        zsh-defer = {
          github = "romkatv/zsh-defer";
        };
        zsh-autosuggestions = {
          github = "zsh-users/zsh-autosuggestions";
          apply = [ "defer" ];
        };
        zsh-syntax-highlighting = {
          github = "zsh-users/zsh-syntax-highlighting";
          apply = [ "defer" ];
        };
        zsh-history-substring-search = {
          github = "zsh-users/zsh-history-substring-search";
          apply = [ "defer" ];
        };
        zsh-completions = {
          github = "zsh-users/zsh-completions";
          apply = [ "defer" ];
        };
      };
    };
  };
}
