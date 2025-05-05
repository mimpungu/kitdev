#!/bin/bash
# Deo - Web Optimizer (.sh)
# Utilise minify pour optimiser HTML, CSS, JS tout en conservant la structure

SRC_DIR=$(pwd)
DIST_DIR="$SRC_DIR/dist"
mkdir -p "$DIST_DIR"

echo "Optimisation des fichiers HTML..."
for file in $SRC_DIR/*.html; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    if command -v minify &> /dev/null; then
        minify "$file" > "$DIST_DIR/$filename"
    else
        cp "$file" "$DIST_DIR/$filename"
    fi
done

echo "Optimisation des fichiers CSS..."
for file in $SRC_DIR/*.css; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    if command -v minify &> /dev/null; then
        minify "$file" > "$DIST_DIR/$filename"
    else
        cp "$file" "$DIST_DIR/$filename"
    fi
done

echo "Optimisation des fichiers JS..."
for file in $SRC_DIR/*.js; do
    [ -f "$file" ] || continue
    filename=$(basename "$file")
    if command -v minify &> /dev/null; then
        minify "$file" > "$DIST_DIR/$filename"
    else
        cp "$file" "$DIST_DIR/$filename"
    fi
done

echo "Copie brute des fichiers PHP, Java, Dart..."
cp $SRC_DIR/*.{php,java,dart} "$DIST_DIR/" 2>/dev/null

echo "✅ Optimisation terminée dans : $DIST_DIR"
