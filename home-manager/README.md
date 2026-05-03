# Home Manager Configuration

## Linux / WSL2

### 前提条件

- git

### 1. Nix のインストール

[Determinate Systems インストーラー](https://determinate.systems/posts/determinate-nix-installer)を使うのが推奨（flakes がデフォルト有効）。

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

インストール後、シェルを再起動するか以下を実行する。

```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

<details>
<summary>公式インストーラーを使う場合</summary>

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

公式インストーラーの場合は flakes が無効なので `~/.config/nix/nix.conf` に追記する。

```
experimental-features = nix-command flakes
```

</details>

### 2. このリポジトリをクローンする

```bash
git clone <this-repo> ~/.config
cd ~/.config/home-manager
```

### 3. user.nix を作成する

`user.nix.example` をコピーして自分の環境に合わせて編集する。

```bash
cp user.nix.example user.nix
# user.nix を編集
```

### 4. git の追跡から除外する

`user.nix` に個人情報（メールアドレス・SSHキーなど）が含まれるため、
git に変更を追跡させないようにする。

```bash
git update-index --skip-worktree home-manager/user.nix
```

### 5. 適用する

初回のみ（`home-manager` コマンドがない状態）:

```bash
nix run home-manager/master -- switch --flake ~/.config/home-manager
```

2回目以降:

```bash
home-manager switch
```

---

## macOS

### 1. Nix のインストール

Linux と同じ手順。

### 2. Homebrew のインストール

nix-darwin の homebrew モジュールが Homebrew 経由のアプリを管理するため、事前に手動でインストールする。

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 3. このリポジトリをクローンする

```bash
git clone <this-repo> ~/.config
cd ~/.config/home-manager
```

### 4. user.nix を作成する

```bash
cp user.nix.example user.nix
# user.nix を編集（system は aarch64-darwin / x86_64-darwin、homeDirectory は /Users/username）
```

### 5. git の追跡から除外する

```bash
git update-index --skip-worktree home-manager/user.nix
```

### 6. nix-darwin を適用する

```bash
nix run nix-darwin -- switch --flake ~/.config/home-manager
```

2回目以降:

```bash
darwin-rebuild switch --flake ~/.config/home-manager
```

### 7. Home Manager を適用する

```bash
nix run home-manager/master -- switch --flake ~/.config/home-manager
```

2回目以降:

```bash
home-manager switch
```

---

## user.nix の設定項目

| キー | 説明 |
|------|------|
| `system` | `x86_64-linux` / `aarch64-linux` / `aarch64-darwin` / `x86_64-darwin` |
| `username` | ユーザー名 |
| `homeDirectory` | Linux: `/home/username`、macOS: `/Users/username` |
| `git.name` | git のユーザー名 |
| `git.email` | git のメールアドレス |
| `git.signingKey` | コミット署名用 SSH 公開鍵 |
| `gitlab.*` | GitLab 用の設定（不要なら削除可） |

## 注意

- `user.nix` はコミットしない（`--skip-worktree` で管理）
- PC を移行した際は手順をやり直す
