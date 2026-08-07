#!/usr/bin/env bash
# Recopie les deux applications dans le portail (www/langue, www/revision).
# À relancer après toute modification de quiz-app ou quiz-thales, puis commit.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
LANGUE="${1:-$HOME/quiz-app/www}"
REVISION="${2:-$HOME/quiz-thales/www}"

rsync -a --delete "$LANGUE/"   "$HERE/www/langue/"
rsync -a --delete "$REVISION/" "$HERE/www/revision/"

# SÉCURITÉ : cette page est publique. On retire la config Firebase de CyberRévision
# (clé Web + URL de la Realtime Database) et le module de défi multijoueur, qui n'ont
# rien à faire sur une page publique. Le défi reste disponible dans l'APK.
rm -f "$HERE/www/revision/firebase-config.js" \
      "$HERE/www/revision/firebase-challenge.js" \
      "$HERE/www/revision/firebase-app-compat.js" \
      "$HERE/www/revision/firebase-database-compat.js"
# Retire les <script> firebase-* du index.html de la copie publique.
sed -i '/<script[^>]*firebase-[a-z]*\.js/d' "$HERE/www/revision/index.html"

# Le bandeau « mise à jour disponible » (update-check.js) sert à l'auto-MAJ de
# l'APK : inutile sur le web. On le retire des deux apps de la copie publique.
rm -f "$HERE/www/langue/update-check.js" "$HERE/www/revision/update-check.js"
sed -i '/<script[^>]*update-check\.js/d' "$HERE/www/langue/index.html" "$HERE/www/revision/index.html"

echo "OK — apps synchronisées (Firebase + bandeau MAJ retirés du bundle public)"
