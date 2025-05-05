#!/bin/bash
# Deo - Script personnalisé d'optimisation

echo "Optimisation personnalisée lancée..."

# Exemple simple : minify un fichier HTML si minify est installé
if command -v minify &> /dev/null; then
    minify exemple.html > exemple.min.html
    echo "Minification réussie avec minify."
else
    echo "minify n'est pas installé."
fi
