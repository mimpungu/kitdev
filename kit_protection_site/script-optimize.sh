# ====================================
#   ____                         __  __ 
#  |  _ \  ___  _ __ ___   ___  |  \/  |
#  | | | |/ _ \| '_ ` _ \ / _ \ | |\/| |
#  | |_| | (_) | | | | | |  __/ | |  | |
#  |____/ \___/|_| |_| |_|\___| |_|  |_|
#                                      
#          DEUS M - Web Optimizer
# ====================================
# Optimise vos projets HTML/CSS/JS/PHP/Java/Dart/Flutter :
# - Minification HTML/CSS
# - Obfuscation JavaScript
# - Compilation Java et Dart
# - Build Flutter Web
# - Copie des fichiers PHP

#   ____             _     
#  |  _ \  ___   ___| |__  
#  | | | |/ _ \ / __| '_ \ 
#  | |_| | (_) | (__| | | |
#  |____/ \___/ \___|_| |_|
#                           
#     DEUS - Web Optimizer
# ====================================

#!/bin/bash

# === CONFIGURATION ===
SRC_DIR=$(pwd)
DIST_DIR="$SRC_DIR/dist"
mkdir -p "$DIST_DIR"

# === OUTILS REQUIS ===
# Assure-toi d’avoir :
# npm install -g html-minifier clean-css-cli javascript-obfuscator
# PHP installé
# javac (Java compiler)
# dart & flutter installés (si besoin)

echo "Dossier de sortie: $DIST_DIR"

# === HTML ===
echo "Minification des fichiers HTML..."
find "$SRC_DIR/html" -name "*.html" | while read file; do
  base=$(basename "$file")
  html-minifier --collapse-whitespace --remove-comments --minify-css true --minify-js true "$file" -o "$DIST_DIR/$base"
done

# === CSS ===
echo "Minification des fichiers CSS..."
find "$SRC_DIR/css" -name "*.css" | while read file; do
  base=$(basename "$file")
  cleancss -o "$DIST_DIR/$base" "$file"
done

# === JS ===
echo "Obfuscation des fichiers JavaScript..."
find "$SRC_DIR/js" -name "*.js" | while read file; do
  base=$(basename "$file")
  javascript-obfuscator "$file" --output "$DIST_DIR/$base"
done

# === PHP ===
echo "Copie brute des fichiers PHP (pas de minification directe)..."
find "$SRC_DIR/php" -name "*.php" | while read file; do
  base=$(basename "$file")
  cp "$file" "$DIST_DIR/$base"
done

# === JAVA ===
echo "Compilation des fichiers Java..."
mkdir -p "$DIST_DIR/java_classes"
find "$SRC_DIR/java" -name "*.java" | while read file; do
  javac -d "$DIST_DIR/java_classes" "$file"
done

# === DART ===
echo "Compilation des fichiers Dart..."
find "$SRC_DIR/dart" -name "*.dart" | while read file; do
  base=$(basename "$file" .dart)
  dart compile exe "$file" -o "$DIST_DIR/$base"
done

# === FLUTTER (web build) ===
if [ -d "$SRC_DIR/flutter" ]; then
  echo "Build Flutter Web..."
  cd flutter
  flutter build web
  cp -r build/web/* "$DIST_DIR/"
  cd ..
fi

echo "✅ Optimisation terminée. Tous les fichiers sont dans: $DIST_DIR"
