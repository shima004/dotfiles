# Home Manager Configuration

## セットアップ

### 1. user.nix を作成する

`user.nix.example` をコピーして自分の環境に合わせて編集する。

```bash
cp user.nix.example user.nix
# user.nix を編集
```

### 2. git の追跡から除外する

`user.nix` に個人情報（メールアドレス・SSHキーなど）が含まれるため、
git に変更を追跡させないようにする。

```bash
git update-index --skip-worktree home-manager/user.nix
```

### 3. 適用する

```bash
home-manager switch
```
