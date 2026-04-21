#!/bin/bash

# スクリプトの場所を自動取得
DOT_DIR=$(cd $(dirname $0); pwd)

# --- リンクしたいファイル・フォルダのリスト ---
# リポジトリ内の名前をドット込みで記述してください
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
# --------------------------------------------

# バックアップ用ディレクトリ
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOT_DIR"

for item in "${DOT_FILES[@]}"; do
    src="${DOT_DIR}/${item}"
    target="${HOME}/${item}"

    # リポジトリ側にファイル/フォルダが存在するか確認
    if [ ! -e "$src" ]; then
        echo "Skipping: $src not found."
        continue
    fi

    # 既存の実体（リンクではない）があればバックアップ
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    # シンボリックリンクの作成
    # -s: シンボリックリンク, -n: リンク先がディレクトリでも上書き, -f: 強制, -v: 実行結果表示
    ln -snfv "$src" "$target"
done

echo "--------------------------------"
echo "Setup complete! Please restart your shell."

