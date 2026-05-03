{ config, pkgs, userConfig, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = userConfig.git.signingKey;
      signByDefault = true;
    };

    settings = {
      user = {
        name = userConfig.git.name;
        email = userConfig.git.email;
      };
      gpg.format = "ssh";
      core.editor = "code --wait";
      pull.rebase = true;
      init.defaultBranch = "main";

      includeIf = {
        "hasconfig:remote.*.url:git@${userConfig.gitlab.host}:*/**".path =
          "~/.config/git/gitconfig-gitlab";
        "hasconfig:remote.*.url:https://${userConfig.gitlab.host}/**".path =
          "~/.config/git/gitconfig-gitlab";
      };
    };
  };

  home.file.".config/git/gitconfig-gitlab".text = ''
    [user]
      signingkey = ${userConfig.gitlab.signingKey}
      name = ${userConfig.gitlab.name}
      email = ${userConfig.gitlab.email}

    [credential]
      helper = store
  '';
}
