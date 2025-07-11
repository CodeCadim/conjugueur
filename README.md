# Conjugueur - Application de conjugaison française

Une application web interactive développée en Svelte pour consulter les conjugaisons de verbes français.

## Fonctionnalités

- **Recherche intelligente** : Recherchez n'importe quel verbe français avec autocomplétion
- **Conjugaisons complètes** : Affichage de tous les temps et modes de conjugaison
- **Interface intuitive** : Design moderne et responsive
- **Base de données riche** : Plus de 9000 verbes français avec leurs conjugaisons complètes
- **Informations détaillées** : Participes, auxiliaires et formes pronominales

## Technologies utilisées

- **Svelte** - Framework JavaScript moderne et performant
- **Vite** - Outil de build rapide et moderne
- **CSS3** - Styles personnalisés pour une interface élégante
- **JSON** - Base de données des conjugaisons

## Installation

1. Clonez le dépôt :
```bash
git clone <url-du-depot>
cd conjugueur-app
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
conjugueur-app/
├── src/
│   ├── App.svelte          # Composant principal
│   ├── app.css             # Styles globaux
│   ├── main.js             # Point d'entrée
│   └── conjuguaison.json   # Base de données des verbes
├── index.html              # Template HTML
├── vite.config.js          # Configuration Vite
├── package.json            # Dépendances et scripts
└── README.md               # Documentation
```

## Utilisation

1. **Recherche** : Tapez le début d'un verbe dans la barre de recherche
2. **Sélection** : Cliquez sur un verbe dans les suggestions qui apparaissent
3. **Consultation** : Explorez toutes les conjugaisons du verbe sélectionné

### Temps de conjugaison disponibles

- Présent
- Imparfait  
- Passé simple
- Futur simple
- Passé composé
- Plus-que-parfait

## Données

L'application utilise une base de données JSON contenant :
- **Infinitif** du verbe
- **Participe présent** et **participe passé**
- **Auxiliaire** utilisé (avoir/être)
- **Forme pronominale** si applicable
- **Conjugaisons complètes** pour tous les temps principaux

Chaque conjugaison suit l'ordre standard des pronoms personnels :
je, tu, il/elle, nous, vous, ils/elles

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