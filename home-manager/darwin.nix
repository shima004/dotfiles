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

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";

    casks = [
      "google-chrome"
      "claude"
      "chatgpt"
      "visual-studio-code"
      "warp"
      "bitwarden"
      "karabiner-elements"
      "docker-desktop"
      "discord"
      "microsoft-teams"
      "cloudflare-warp"
    ];
  };

  system.defaults = {
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
    };
    menuExtraClock.ShowSeconds = true;
    controlcenter.BatteryShowPercentage = true;
    dock.show-recents = false;
  };

  system.stateVersion = 5;
}
