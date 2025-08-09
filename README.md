# Application d'Émissions de Streaming

## Description

Cette application Flutter a été développée dans le cadre de la formation DCLIC niveau avancé. Elle affiche une liste d'émissions de streaming avec des détails sur chaque émission, utilisant des concepts avancés de Flutter comme la grille d'images réactives, les pages, la navigation et les animations héros.

## Fonctionnalités

### 🏠 Page Principale (MapremierePage)
- **AppBar** : Barre d'application avec couleur amber, bouton de recherche, titre "Vos émissions en streaming" et bouton de liste
- **Grille Réactive** : Affichage des émissions dans une grille responsive utilisant le package `responsive_grid`
- **Navigation** : Barre de navigation en bas avec trois onglets (Accueil, Recherche, Profil)

### 📺 Émissions de Streaming (IdentificationStreaming)
Chaque émission affiche :
- Une image de fond colorée avec icône de lecture
- Le nom de l'émission
- La chaîne radio
- Animation de transition vers la page de détails

### 🎬 Page de Détails (AlbumStreaming)
- **Animation Hero** : Transition fluide de l'image depuis la liste
- **Informations détaillées** : Titre et chaîne radio avec overlay
- **Liste des diffusions** : Affichage des diffusions avec dates et icônes de volume

## Structure du Code

### Classes Principales

1. **MonApplication** : Point d'entrée de l'application
2. **MapremierePage** : Page principale avec navigation
3. **IdentificationStreaming** : Widget pour afficher une émission
4. **partieGrilleImage** : Grille réactive des émissions
5. **AlbumStreaming** : Page de détails d'une émission

### Technologies Utilisées

- **Flutter** : Framework de développement mobile
- **responsive_grid** : Package pour créer des grilles réactives
- **Hero Animation** : Animations de transition entre pages
- **Material Design** : Interface utilisateur moderne

## Installation et Exécution

1. **Cloner le projet** :
   ```bash
   git clone [url-du-projet]
   cd streaming_app
   ```

2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Lancer l'application** :
   ```bash
   flutter run
   ```

## Configuration

### Dépendances (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  responsive_grid: ^2.4.4
```

### Assets
- Dossier `assets/images/` pour les images des émissions
- Configuration dans `pubspec.yaml` pour inclure les assets

## Fonctionnalités Avancées

### Grille Réactive
- Utilisation de `ResponsiveGridList` avec `desiredItemWidth: 150`
- Espacement minimal de 10 pixels entre les éléments
- Adaptation automatique à différentes tailles d'écran

### Animations
- **Hero Animation** : Transition fluide des images entre les pages
- **Navigation** : Transitions Material Design par défaut
- **Interactions** : GestureDetector pour les interactions utilisateur

### Design
- **Couleurs** : Thème amber pour l'AppBar
- **Ombres** : Effets de profondeur sur les cartes
- **Bordures arrondies** : Design moderne avec ClipRRect
- **Gradients** : Overlay sur les images de détails

## Émissions Disponibles

1. **Documentaires** - Radio 4 (Bleu)
2. **Tendances Mode** - Radio 3 (Rose)
3. **Enquêtes Criminelles** - Radio 2 (Rouge)
4. **Match de Foot** - Radio 5 (Vert)
5. **Streaming Météo** - Radio 1 (Cyan)
6. **Que des news** - Radio 4 (Orange)

## Améliorations Possibles

- Ajout de vraies images pour chaque émission
- Implémentation de la fonctionnalité de recherche
- Ajout de la lecture audio des diffusions
- Système de favoris fonctionnel
- Persistance des données utilisateur
- Tests unitaires et d'intégration

## Auteur

Développé dans le cadre de la formation DCLIC niveau avancé.

## Licence

Ce projet est destiné à des fins éducatives.
