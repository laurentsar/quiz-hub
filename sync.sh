#!/usr/bin/env bash
# Recopie les deux applications dans le portail (www/langue, www/revision).
# À relancer après toute modification de quiz-app ou quiz-thales, puis commit.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
LANGUE="${1:-$HOME/quiz-app/www}"
REVISION="${2:-$HOME/quiz-thales/www}"

rsync -a --delete "$LANGUE/"   "$HERE/www/langue/"
rsync -a --delete "$REVISION/" "$HERE/www/revision/"
echo "OK — apps synchronisées dans www/langue et www/revision"
