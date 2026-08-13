#!/usr/bin/env bash
# 雙擊即可對「這個腳本所在的資料夾」執行 git commit + push
# 也可以在命令列使用: ./git-push.command [commit 訊息]

set -e

# 關鍵:切換到腳本自己所在的資料夾
cd "$(dirname "$0")"

MSG="${1:-auto commit $(date '+%Y-%m-%d %H:%M:%S')}"

# 確認這是一個 git 資料夾
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "錯誤: $(pwd) 不是一個 git 資料夾"
    exit 1
fi

# 檢查有沒有變更
if [ -z "$(git status --porcelain)" ]; then
    echo "沒有變更，不需要 commit"
    exit 0
fi

git add -A
git commit -m "$MSG"
git push

echo "完成! 已 commit 並 push 到遠端"