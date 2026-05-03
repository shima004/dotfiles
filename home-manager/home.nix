{
  config,
  pkgs,
  lib,
  userConfig,
  ...
}:

{
  imports = [
    ./zsh.nix
    ./sheldon.nix
    ./starship.nix
    ./git.nix
  ];

  home.username = userConfig.username;
  home.homeDirectory = userConfig.homeDirectory;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # ----- Download and archive tools -----
    curl # HTTPクライアント・ファイル転送ツール
    wget # ファイルダウンロードツール
    unzip # ZIPファイル解凍ツール

    # ----- Utilities -----
    fzf # ファジーファインダー（インタラクティブな絞り込み検索）
    lsd # lsの代替（アイコン付き・カラフルなファイル一覧）
    bat # catの代替（シンタックスハイライト・行番号表示）
    btop # topの代替（リソースモニター）
    zellij # ターミナルマルチプレクサ（tmux代替）
    git # バージョン管理システム
    fontconfig # フォント設定・管理ライブラリ
    vim # テキストエディタ
    jq # JSONパース・加工ツール
    ghq # Gitリポジトリ一元管理ツール
    git-wt # git worktreeを便利に操作するツール
    socat # 汎用ネットワークツール（ポート転送・プロキシなど）

    # ----- Programing languages -----
    go # Goプログラミング言語
    jdk21 # Java Development Kit 21
    nodejs # JavaScript/TypeScriptランタイム
    python3 # Pythonプログラミング言語
    protobuf # Protocol Buffers（スキーマ定義・シリアライズ）

    # ----- Programming language tools -----
    uv # Pythonパッケージマネージャ（pip代替・高速）
    nixfmt # Nixコードフォーマッタ

    # ----- Cloud and infrastructure tools -----
    awscli2 # AWS コマンドラインインターフェース
    terraform # インフラのコード管理ツール（IaC）

    # ----- Kubernetes -----
    kubie # kubectlコンテキスト・namespace切り替えツール
    kubectl # Kubernetesクラスタ操作CLIツール
    helm # Kubernetesパッケージマネージャ
    helmfile # Helmチャートの管理・デプロイツール
  ];

  home.file = {
    ".local/share/fonts/moralerspace" = {
      source = pkgs.fetchzip {
        url = "https://github.com/yuru7/moralerspace/releases/download/v2.0.0/Moralerspace_v2.0.0.zip";
        sha256 = "1d5plnqbgvgw01bvdvxq1xmr34kqfwj7pcgfhvkxzgjqkyvljsj5";
      };
      recursive = true;
    };
  };

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.activation.addZshToShells = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! grep -q "$HOME/.nix-profile/bin/zsh" /etc/shells; then
      echo "$HOME/.nix-profile/bin/zsh" | /usr/bin/sudo tee -a /etc/shells
    fi
  '';

  home.activation.refreshFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.fontconfig}/bin/fc-cache -f
  '';
}
