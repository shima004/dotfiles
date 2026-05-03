{ config, pkgs, lib, userConfig, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";

  users.users.${userConfig.username} = {
    home = userConfig.homeDirectory;
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";

    casks = [
      "google-chrome"
    ];
  };

  system.stateVersion = 5;
}
