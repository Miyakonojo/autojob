#!/bin/bash
set -e
content_dir="/home/mono-96/www/mono-96.jp/tmp/test"

set -x
cd "$content_dir"
git add -A
git commit -m "Commit at $(date "+%Y-%m-%d %T")" || true
git push -f origin master:master

