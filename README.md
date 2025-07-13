# Conjugueur

Application web pour consulter les conjugaisons de verbes français.

## Fonctionnalités

- Recherche de verbes avec autocomplétion
- Affichage des conjugaisons pour tous les temps et modes
- Interface qui s'adapte au thème clair/sombre du navigateur
- 956 verbes français disponibles

## Installation

1. Clonez le dépôt :
```bash
git clone https://github.com/CodeCadim/conjugueur.git
cd conjugueur
```

2. Installez les dépendances :
```bash
npm install
```

3. Lancez le serveur de développement :
```bash
npm run dev
```

4. Ouvrez `http://localhost:3000` dans votre navigateur

## Structure du projet

```
conjugueur/
├── src/                    # Code source de l'application
├── public/
│   ├── index.json          # Liste des verbes (16KB)
│   └── verbs/              # Fichiers de conjugaisons individuels (~3KB chacun)
├── data/                   # Fichiers de données sources
└── package.json
```

## Comment ça fonctionne

L'application charge d'abord la liste des verbes, puis récupère les conjugaisons individuellement quand on sélectionne un verbe. Les verbes consultés sont mis en cache.

## Modes de conjugaison

- **Indicatif** : présent, imparfait, passé simple, futur simple, passé composé, plus-que-parfait, passé antérieur, futur antérieur
- **Subjonctif** : présent, imparfait, passé, plus-que-parfait  
- **Conditionnel** : présent, passé, passé 2ème forme
- **Impératif** : présent, passé

## Technologies utilisées

- Svelte
- Vite
- CSS avec variables pour les thèmes
- JSON pour les données

## Construction pour production

```bash
npm run build
```

Les fichiers de production sont générés dans le dossier `dist/`.

## Données

Chaque verbe contient son infinitif, ses participes, son auxiliaire, sa forme pronominale et ses conjugaisons complètes.

## Licence

ISC