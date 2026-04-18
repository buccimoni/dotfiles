#!/bin/bash

# --- 安全対策・警告メッセージ ---
echo "==========================================="
echo "🚨 ⚠️ ドットファイル自動展開スクリプト (WARNING) ⚠️ 🚨"
echo "このスクリプトはシステム設定ファイルを直接操作します。"
echo "実行前に、重要な設定ファイルのバックアップを取ってください。"
echo "続行してもよろしいですか？ (y/N): "
read -r confirmation

if [[ "$confirmation" != "y" ]]; then
    echo "処理をキャンセルしました。安全第一でお願いします。"
    exit 1
fi

# --- 設定変数 ---
# 現在のディレクトリ（dotfilesリポジトリ）からの相対パスです。
REPO_DIR=$(pwd)

# リンクを作成する対象ファイル/ディレクトリのリスト (ここはあなたのrepo構造に合わせて調整が必要です)
# 例: .zshrc, git/, vim/ など、実際にリンクしたいものを記述してください。
TARGETS=(
    ".config/"      # zshの設定ファイルをリンクする場合
    ".tmux/"      # git関連のファイルをリンクする場合
    ".p10k.zsh"          # もしルートに直接置かれているなら
    ".tmux.conf"
    ".vimrc"
    ".zshenv"
    ".zshrc"
)

echo "--- 🚀 シンボリックリンク作成を開始します ---"

SUCCESS_COUNT=0
FAIL_COUNT=0

for SOURCE in "${TARGETS[@]}"; do
    SOURCE_PATH="${REPO_DIR}/${SOURCE}"
    
    # ターゲットとなるホームディレクトリのパスを決定
    # 例: zsh/.zshrc -> ~/.zshrc
    if [[ "$SOURCE" == *".*" ]]; then
        # ファイルの場合 (例: .vimrc)
        TARGET_PATH="$HOME/$SOURCE"
    else
        # ディレクトリや複雑な構造の場合 (例: zsh/)
        FILENAME=$(basename "${SOURCE}") # 例: zsh
        TARGET_PATH="$HOME/$FILENAME"  # 例: ~/.zsh
    fi

    echo ""
    echo ">>> 処理中: ${SOURCE} -> ${TARGET_PATH}"

    # 1. 既存のファイルが存在するかチェック
    if [ -e "$TARGET_PATH" ]; then
        read -r -p "  [!] $TARGET_PATH は既に存在します。上書き（リンク化）しますか？ (y/N): " confirmation_exist
        if [[ "$confirmation_exist" != "y" ]]; then
            echo "  -> ユーザーの指示によりスキップされました。"
            continue
        fi
    fi

    # 2. シンボリックリンクを作成
    if [ -e "$SOURCE_PATH" ]; then
        # シンボリックリンクで上書き（既存ファイルを削除してからリンク化）
        rm -rf "$TARGET_PATH" # 安全のため、まず完全に削除する
        ln -s "$SOURCE_PATH" "$TARGET_PATH"
        echo "  ✅ 成功: $TARGET_PATH にシンボリックリンクを作成しました。"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    else
        echo "  ❌ エラー: ソースファイル/ディレクトリ ${SOURCE} が見つかりません。スキップします。"
        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi

done

# --- 結果報告 ---
echo ""
echo "==========================================="
echo "🎉 インストールが完了しました！"
echo "成功したリンク数: ${SUCCESS_COUNT} 個"
echo "失敗/スキップした箇所: ${FAIL_COUNT} 箇所"
echo "-------------------------------------------"
echo "💡 確認事項:"
echo "1. 設定は全て $HOME から参照されています。"
echo "2. これ以降、この設定ファイルを編集する際は、必ず dotfilesリポジトリ内のソースファイル（例: ./zsh/.zshrc）から行ってください。"

