{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:

{
  system.primaryUser = userConfig.username;
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

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
      "claude"
      "visual-studio-code"
      "warp"
      "bitwarden"
    ];
  };

  system.stateVersion = 5;
}
