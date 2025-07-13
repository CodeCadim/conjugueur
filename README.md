# Conjugueur - Application de conjugaison française

Une application web interactive développée en Svelte pour consulter les conjugaisons de verbes français.

## Fonctionnalités

- **Recherche intelligente** : Recherchez n'importe quel verbe français avec autocomplétion native HTML
- **Conjugaisons complètes** : Affichage de tous les temps et modes de conjugaison (Indicatif, Subjonctif, Conditionnel, Impératif)
- **Interface adaptative** : Design moderne et responsive avec support automatique du thème sombre/clair
- **Performance optimisée** : Chargement initial ultra-rapide (16KB) avec lazy loading des verbes
- **Base de données riche** : 956 verbes français avec leurs conjugaisons complètes
- **Informations détaillées** : Participes, auxiliaires et formes pronominales
- **Organisation intuitive** : Affichage en colonnes (singulier/pluriel) avec onglets par mode

## Technologies utilisées

- **Svelte** - Framework JavaScript moderne et performant
- **Vite** - Outil de build rapide et moderne
- **CSS3** - Variables CSS pour le theming automatique
- **HTML5** - Datalist native pour l'autocomplétion
- **JSON** - Architecture distribuée avec fichiers individuels par verbe

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

4. Ouvrez votre navigateur à l'adresse : `http://localhost:3000`

## Scripts disponibles

- `npm run dev` - Lance le serveur de développement
- `npm run build` - Construit l'application pour la production
- `npm run preview` - Prévisualise la version de production

## Structure du projet

```
conjugueur/
├── src/
│   ├── App.svelte          # Composant principal
│   ├── app.css             # Styles globaux avec variables CSS
│   └── main.js             # Point d'entrée
├── public/
│   ├── index.json          # Index des 956 verbes (16KB)
│   └── verbs/              # Dossier contenant 956 fichiers JSON individuels
│       ├── abandonner.json # ~3KB par verbe
│       ├── abattre.json
│       └── ...
├── data/                   # Fichiers sources (développement uniquement)
│   ├── conjuguaison.json   # Base de données source (2.5MB)
│   └── split-json.sh       # Script de génération des fichiers individuels
├── index.html              # Template HTML
├── vite.config.js          # Configuration Vite avec base relative
├── package.json            # Dépendances et scripts
└── README.md               # Documentation
```

## Architecture de performance

L'application utilise une architecture optimisée pour le chargement :

1. **Chargement initial** : Seul l'index des verbes (16KB) est chargé
2. **Recherche** : Utilise une datalist HTML native pour l'autocomplétion  
3. **Lazy loading** : Les conjugaisons sont chargées à la demande (~3KB par verbe)
4. **Cache intelligent** : Les verbes consultés sont mis en cache côté client
5. **Réduction de 99.4%** : De 2.5MB initial à 16KB + chargement à la demande

## Utilisation

1. **Recherche** : Tapez le début d'un verbe dans la barre de recherche
2. **Autocomplétion** : Sélectionnez un verbe dans la liste déroulante native
3. **Consultation** : Explorez toutes les conjugaisons organisées par mode grammatical
4. **Navigation** : Utilisez les onglets pour passer d'un mode à l'autre

### Modes de conjugaison disponibles

**Indicatif** :
- Présent, Imparfait, Passé simple, Futur simple
- Passé composé, Plus-que-parfait, Passé antérieur, Futur antérieur

**Subjonctif** :
- Présent, Imparfait, Passé, Plus-que-parfait

**Conditionnel** :
- Présent, Passé, Passé 2ème forme

**Impératif** :
- Présent, Passé

## Thème automatique

L'application détecte automatiquement la préférence de thème de l'utilisateur :
- **Thème clair** : Couleurs classiques pour une lecture optimale en journée
- **Thème sombre** : Palette sombre pour réduire la fatigue oculaire
- **Transition fluide** : Changement automatique selon les paramètres système/navigateur

## Données

L'application utilise une base de données JSON optimisée contenant :
- **Infinitif** du verbe
- **Participe présent** et **participe passé**  
- **Auxiliaire** utilisé (avoir/être)
- **Forme pronominale** si applicable
- **Conjugaisons complètes** pour tous les temps et modes

Chaque conjugaison suit l'ordre standard des pronoms personnels :
je, tu, il/elle, nous, vous, ils/elles

## Hébergement

L'application est conçue pour être hébergée dans un sous-dossier :
- Utilise des chemins relatifs pour toutes les ressources
- Configuration Vite avec `base: './'`
- Compatible avec GitHub Pages, Netlify, etc.

## Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Forkez le projet
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout nouvelle fonctionnalité'`)
4. Poussez vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Ouvrez une Pull Request

## Licence

Ce projet est sous licence ISC.

## Auteur

Développé avec ❤️ pour l'apprentissage du français.