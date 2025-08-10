# Application d'Émissions de Streaming

## Description

Cette application Flutter a été développée dans le cadre de la formation DCLIC niveau avancé. Elle affiche une liste d'émissions de streaming avec des détails sur chaque émission, utilisant des concepts avancés de Flutter comme la grille d'images réactives, les pages, la navigation et les animations héros.

## Fonctionnalités

### 🏠 Page Principale (Accueil)
- **AppBar** : Barre d'application avec couleur amber, bouton de recherche, titre "Vos émissions en streaming" et bouton de catégories
- **Grille Réactive** : Affichage des émissions dans une grille responsive utilisant le package `responsive_grid`
- **Navigation** : Barre de navigation en bas avec trois onglets (Accueil, Recherche, Profil)
- **Filtrage par catégorie** : Possibilité de filtrer les émissions par catégorie
- **Gestion des favoris** : Système de favoris intégré avec persistance locale

### 🔍 Page de Recherche
- **Barre de recherche** : Recherche en temps réel dans les émissions
- **Recherche multicritères** : Recherche par nom, chaîne radio, catégorie ou description
- **Interface intuitive** : Affichage des résultats en temps réel
- **Gestion des états vides** : Messages informatifs quand aucun résultat n'est trouvé

### 👤 Page Profil
- **Statistiques utilisateur** : Nombre de favoris, catégories disponibles, écoutes
- **Mes favoris** : Affichage de toutes les émissions favorites
- **Interface moderne** : Design épuré avec cartes et statistiques

### 📺 Émissions de Streaming (IdentificationStreaming)

Chaque émission affiche :
- Une image de fond avec badge de catégorie
- Bouton favori interactif
- Le nom de l'émission et la chaîne radio
- Animation de transition vers la page de détails

### 🎬 Page de Détails (AlbumStreaming)
- **Animation Hero** : Transition fluide de l'image depuis la liste
- **Informations détaillées** : Titre, chaîne radio, catégorie et description
- **Liste des diffusions** : Affichage des diffusions avec dates et boutons de lecture
- **Gestion des favoris** : Ajout/suppression des favoris directement depuis les détails

## Architecture et Structure du Code

### Classes Principales

1. **MonApplication** : Point d'entrée de l'application avec configuration du thème
2. **EmissionStreaming** : Modèle de données pour représenter une émission
3. **StreamingService** : Service de gestion des données (émissions, favoris, recherche)
4. **MapremierePage** : Page principale avec navigation par onglets
5. **AccueilPage** : Page d'accueil avec grille d'émissions et filtres
6. **RecherchePage** : Page de recherche avec fonctionnalité de recherche en temps réel
7. **ProfilPage** : Page profil utilisateur avec statistiques et favoris
8. **IdentificationStreaming** : Widget pour afficher une émission dans la grille
9. **partieGrilleImage** : Grille réactive des émissions
10. **AlbumStreaming** : Page de détails d'une émission

### Technologies Utilisées

- **Flutter** : Framework de développement mobile
- **responsive_grid** : Package pour créer des grilles réactives
- **Hero Animation** : Animations de transition entre pages
- **Material Design 3** : Interface utilisateur moderne
- **PageView** : Navigation fluide entre les onglets

## Installation et Exécution

### Prérequis
- Flutter SDK (version 3.8.1 ou supérieure)
- Dart SDK (version 3.8.1 ou supérieure)
- Android Studio ou VS Code avec l'extension Flutter
- Émulateur Android ou appareil physique

### Étapes d'installation

1. **Cloner le projet** :
   ```bash
   git clone https://github.com/Patrickleondev/streaming_app.git
   cd streaming_app
   ```

2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Vérifier la configuration Flutter** :
   ```bash
   flutter doctor
   ```

4. **Lancer l'application** :
   ```bash
   flutter run
   ```

### Compilation APK

Pour générer un APK de production :

```bash
flutter build apk --release
```

L'APK sera généré dans : `build/app/outputs/flutter-apk/app-release.apk`

## Configuration

### Dépendances (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  responsive_grid: ^2.4.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

### Assets

- Dossier `assets/images/` pour les images des émissions
- Configuration dans `pubspec.yaml` pour inclure les assets :

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

## Fonctionnalités Avancées

### Grille Réactive
- Utilisation de `ResponsiveGridList` avec `desiredItemWidth: 160`
- Espacement minimal de 12 pixels entre les éléments
- Adaptation automatique à différentes tailles d'écran

### Navigation et UX
- **PageView** : Navigation fluide entre les onglets avec animations
- **Recherche en temps réel** : Résultats instantanés lors de la saisie
- **Filtrage dynamique** : Filtres par catégorie avec chips interactifs
- **Gestion des états** : Messages informatifs pour les états vides

### Animations
- **Hero Animation** : Transition fluide des images entre les pages
- **Page transitions** : Animations Material Design entre les onglets
- **Micro-interactions** : Feedback visuel pour les actions utilisateur

### Design
- **Material Design 3** : Utilisation des dernières spécifications Material
- **Couleurs cohérentes** : Thème amber uniforme dans toute l'application
- **Ombres et élévations** : Effets de profondeur sur les cartes
- **Bordures arrondies** : Design moderne avec coins arrondis
- **Gradients** : Overlays sur les images de détails

## Données et Contenu

### Émissions Disponibles

1. **Documentaires** - Radio 4 (Catégorie: Culture)
2. **Tendances Mode** - Radio 3 (Catégorie: Lifestyle)
3. **Enquêtes Criminelles** - Radio 2 (Catégorie: Investigation)
4. **Match de Foot** - Radio 5 (Catégorie: Sport)
5. **Streaming Météo** - Radio 1 (Catégorie: Information)
6. **Que des news** - Radio 4 (Catégorie: Actualité)

### Catégories
- Culture
- Lifestyle
- Investigation
- Sport
- Information
- Actualité

## Test et Qualité

### Tests Unitaires
```bash
flutter test
```

### Analyse du code
```bash
flutter analyze
```

### Performance
```bash
flutter run --profile
```

## Améliorations Futures

### Fonctionnalités suggérées
- **Lecture audio** : Intégration d'un lecteur audio pour les diffusions
- **Notifications** : Notifications push pour les nouvelles émissions
- **Synchronisation cloud** : Sauvegarde des favoris dans le cloud
- **Mode hors ligne** : Téléchargement d'émissions pour l'écoute hors ligne
- **Recommandations** : Système de recommandations basé sur les préférences
- **Partage social** : Partage d'émissions sur les réseaux sociaux
- **Playlist personnalisées** : Création de playlists par l'utilisateur

### Améliorations techniques
- **Tests d'intégration** : Tests end-to-end complets
- **Architecture BLoC** : Migration vers une architecture plus robuste
- **Base de données locale** : Persistance des données avec SQLite
- **API REST** : Intégration avec un backend pour les données en temps réel
- **Accessibilité** : Amélioration de l'accessibilité pour tous les utilisateurs

## Problèmes Connus

### Android
- **NDK Version** : Vérifiez que la version NDK dans `android/app/build.gradle.kts` correspond à votre installation
- **Java Version** : L'application nécessite Java 11 ou supérieur

### Solutions
```kotlin
// Dans android/app/build.gradle.kts
android {
    ndkVersion = "29.0.13599879" // Ajustez selon votre version
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}
```

## Support et Contribution

### Signaler un bug
Créez une issue sur GitHub avec :
- Description détaillée du problème
- Étapes pour reproduire
- Captures d'écran si applicable
- Informations sur l'environnement (OS, version Flutter, etc.)

### Contribuer
1. Fork le projet
2. Créez une branche pour votre fonctionnalité
3. Commitez vos changements
4. Créez une Pull Request

## Licence

Ce projet est développé dans le cadre de la formation DCLIC niveau avancé.

## Auteur

Développé par Patrick-léon dans le cadre de la formation DCLIC niveau avancé en développement mobile.

## Liens Utiles

- [Documentation Flutter](https://docs.flutter.dev/)
- [Responsive Grid Package](https://pub.dev/packages/responsive_grid)
- [Material Design Guidelines](https://material.io/design)
- [Formation DCLIC](https://www.dclic.org/)

---

*Application créée avec ❤️ en utilisant Flutter*