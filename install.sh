#!/bin/bash

# スクリプトの場所を自動取得
DOT_DIR=$(cd $(dirname $0); pwd)

# --- リンクしたいファイル・フォルダのリスト ---
DOT_FILES=(
    .zshrc
    .zshenv
    .p10k.zsh
    .tmux.conf
    .vimrc
    .config
    .tmux
    .vim
)

# 1. PATH の一時追加（~/.local/bin にインストールされる sheldon 用）
export PATH="${HOME}/.local/bin:${PATH}"

# 2. Sheldon のインストール
if ! command -v sheldon &> /dev/null; then
    echo "Sheldon not found. Installing..."
    mkdir -p ~/.local/bin
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
else
    echo "Sheldon is already installed."
fi

# 3. vim-plug (plug.vim) のインストール
PLUG_PATH="${HOME}/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_PATH" ]; then
    echo "vim-plug not found. Installing..."
    curl -fLo "$PLUG_PATH" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "vim-plug is already installed."
fi

# 4. dotfiles のシンボリックリンク作成
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOT_DIR"

for item in "${DOT_FILES[@]}"; do
    src="${DOT_DIR}/${item}"
    target="${HOME}/${item}"

    # リポジトリ側にソースが存在するか確認
    if [ ! -e "$src" ]; then
        echo "Skipping: $src not found."
        continue
    fi

    # 既存の実体があればバックアップ
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    # シンボリックリンクの作成
    ln -snfv "$src" "$target"
done

# 5. ポストインストール処理（sheldon lock など）
if [ -f "${HOME}/.config/sheldon/plugins.toml" ]; then
    echo "Updating sheldon plugins..."
    sheldon lock
fi

echo "--------------------------------"
echo "Setup complete! Please restart your shell."

