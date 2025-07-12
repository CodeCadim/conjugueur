#!/bin/bash

echo "🚀 Séparation du fichier conjuguaison.json en fichiers individuels..."

# Créer le dossier verbs dans public
mkdir -p public/verbs

# 1. Générer le fichier d'index avec tous les infinitifs
echo "📝 Génération de l'index des verbes..."
jq '[.[].infinitif] | sort' public/conjuguaison.json > public/index.json
echo "✅ Index créé : $(jq 'length' public/index.json) verbes"

# 2. Séparer chaque verbe en fichier individuel
echo "📂 Séparation en fichiers individuels..."
counter=0

jq -c '.[]' public/conjuguaison.json | while read verb; do
    # Extraire l'infinitif du verbe
    infinitif=$(echo "$verb" | jq -r '.infinitif')
    
    # Nettoyer le JSON en supprimant _id et _class
    cleaned_verb=$(echo "$verb" | jq 'del(._id, ._class)')
    
    # Sauvegarder dans un fichier individuel
    echo "$cleaned_verb" | jq '.' > "public/verbs/${infinitif}.json"
    
    counter=$((counter + 1))
    if [ $((counter % 100)) -eq 0 ]; then
        echo "   Traité : $counter verbes..."
    fi
done

echo "✅ Séparation terminée : $counter fichiers créés"

# 3. Afficher les statistiques
original_size=$(du -h public/conjuguaison.json | cut -f1)
index_size=$(du -h public/index.json | cut -f1)
verbs_size=$(du -h public/verbs/ | tail -1 | cut -f1)

echo ""
echo "📊 Statistiques :"
echo "   Fichier original : $original_size"
echo "   Index des verbes : $index_size"
echo "   Dossier verbs/   : $verbs_size"
echo "   Nombre de fichiers verbes : $(ls public/verbs/ | wc -l)"

echo ""
echo "🎉 Optimisation terminée !"
echo "   Chargement initial réduit de $original_size à $index_size"