{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      scan_timeout = 100; # ミリ秒（デフォルト30ms）
      command_timeout = 500;
    };
  };
}
