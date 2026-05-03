# Home Manager Configuration

## 前提条件

- Linux / WSL2
- git

## 1. Nix のインストール

[Determinate Systems インストーラー](https://determinate.systems/posts/determinate-nix-installer)を使うのが推奨（flakes がデフォルト有効）。

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール後、シェルを再起動するか以下を実行する。

```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### 公式インストーラーを使う場合

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

公式インストーラーの場合は flakes が無効なので `~/.config/nix/nix.conf` に追記する。

```
experimental-features = nix-command flakes
```

## 2. Home Manager の初回適用

初回は `home-manager` コマンドがないため、`nix run` 経由でフレークを直接指定して実行する。

```bash
nix run home-manager/master -- switch --flake ~/.config/home-manager
```

これにより Home Manager 自体も管理対象になり（`programs.home-manager.enable = true`）、
以降は `home-manager switch` が使えるようになる。

## 3. このリポジトリをクローンする

```bash
git clone <this-repo> ~/.config
cd ~/.config/home-manager
```

## 4. user.nix を作成する

`user.nix.example` をコピーして自分の環境に合わせて編集する。

```bash
cp user.nix.example user.nix
# user.nix を編集
```

## 5. git の追跡から除外する

`user.nix` に個人情報（メールアドレス・SSHキーなど）が含まれるため、
git に変更を追跡させないようにする。

```bash
git update-index --skip-worktree home-manager/user.nix
```

## 6. 適用する

```bash
home-manager switch
```
