#!/bin/bash
# Deo - Script personnalisé
# Optimise un fichier HTML à la manière Calm (structure propre)

FILE="calm.html"
OUT="calm.min.html"

if command -v minify &> /dev/null; then
    minify "$FILE" > "$OUT"
    echo "✅ Fichier minifié : $OUT"
else
    echo "⚠️  minify non installé. Fichier copié tel quel."
    cp "$FILE" "$OUT"
fi
