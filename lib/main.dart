import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() {
  runApp(const MonApplication());
}

/// Classe principale de l'application
/// Point d'entrée de l'application de streaming d'émissions
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application d\'émissions de streaming',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const MapremierePage(),
    );
  }
}

/// Modèle de données pour une émission de streaming
class EmissionStreaming {
  final String id;
  final String nom;
  final String chaineRadio;
  final String imageAsset;
  final String categorie;
  final List<String> diffusions;
  final String description;
  bool isFavorite;

  EmissionStreaming({
    required this.id,
    required this.nom,
    required this.chaineRadio,
    required this.imageAsset,
    required this.categorie,
    required this.diffusions,
    required this.description,
    this.isFavorite = false,
  });
}

/// Service de gestion des données d'émissions
class StreamingService {
  static final List<EmissionStreaming> _emissions = [
    EmissionStreaming(
      id: 'documentaires',
      nom: 'Documentaires',
      chaineRadio: 'Radio 4',
      imageAsset: 'assets/images/parole_de_femme.jpg',
      categorie: 'Culture',
      description: 'Des documentaires captivants sur des sujets variés et enrichissants.',
      diffusions: ['2023-9-28', '2023-8-15', '2023-7-22', '2023-6-10', '2023-5-05'],
    ),
    EmissionStreaming(
      id: 'tendances_mode',
      nom: 'Tendances Mode',
      chaineRadio: 'Radio 3',
      imageAsset: 'assets/images/image.webp',
      categorie: 'Lifestyle',
      description: 'Suivez les dernières tendances de la mode et du style.',
      diffusions: ['2023-9-25', '2023-8-20', '2023-7-18', '2023-6-12', '2023-5-08'],
    ),
    EmissionStreaming(
      id: 'enquetes_criminelles',
      nom: 'Enquêtes Criminelles',
      chaineRadio: 'Radio 2',
      imageAsset: 'assets/images/image2.webp',
      categorie: 'Investigation',
      description: 'Plongez dans le monde fascinant des enquêtes policières.',
      diffusions: ['2023-9-30', '2023-8-28', '2023-7-25', '2023-6-20', '2023-5-15'],
    ),
    EmissionStreaming(
      id: 'match_foot',
      nom: 'Match de Foot',
      chaineRadio: 'Radio 5',
      imageAsset: 'assets/images/image3.webp',
      categorie: 'Sport',
      description: 'Vivez la passion du football avec nos commentaires en direct.',
      diffusions: ['2023-9-27', '2023-8-25', '2023-7-20', '2023-6-15', '2023-5-12'],
    ),
    EmissionStreaming(
      id: 'streaming_meteo',
      nom: 'Streaming Météo',
      chaineRadio: 'Radio 1',
      imageAsset: 'assets/images/OIP.jpeg',
      categorie: 'Information',
      description: 'Toute la météo en temps réel avec nos experts climatologues.',
      diffusions: ['2023-10-01', '2023-9-15', '2023-8-10', '2023-7-05', '2023-6-01'],
    ),
    EmissionStreaming(
      id: 'que_des_news',
      nom: 'Que des news',
      chaineRadio: 'Radio 4',
      imageAsset: 'assets/images/R.jpeg',
      categorie: 'Actualité',
      description: 'L\'actualité décryptée par nos journalistes expérimentés.',
      diffusions: ['2023-9-29', '2023-8-22', '2023-7-17', '2023-6-14', '2023-5-10'],
    ),
  ];

  static List<EmissionStreaming> get emissions => _emissions;

  static List<EmissionStreaming> get favoriteEmissions =>
      _emissions.where((e) => e.isFavorite).toList();

  static List<String> get categories =>
      _emissions.map((e) => e.categorie).toSet().toList();

  static List<EmissionStreaming> searchEmissions(String query) {
    if (query.isEmpty) return _emissions;
    
    final lowerQuery = query.toLowerCase();
    return _emissions.where((emission) =>
        emission.nom.toLowerCase().contains(lowerQuery) ||
        emission.chaineRadio.toLowerCase().contains(lowerQuery) ||
        emission.categorie.toLowerCase().contains(lowerQuery) ||
        emission.description.toLowerCase().contains(lowerQuery)).toList();
  }

  static List<EmissionStreaming> getEmissionsByCategory(String category) {
    return _emissions.where((e) => e.categorie == category).toList();
  }

  static void toggleFavorite(String emissionId) {
    final emission = _emissions.firstWhere((e) => e.id == emissionId);
    emission.isFavorite = !emission.isFavorite;
  }
}

/// Page principale avec navigation et grille d'émissions
/// Contient AppBar amber, grille réactive d'émissions et navigation en bas
class MapremierePage extends StatefulWidget {
  const MapremierePage({super.key});

  @override
  State<MapremierePage> createState() => _MapremierePageState();
}

class _MapremierePageState extends State<MapremierePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          AccueilPage(),
          RecherchePage(),
          ProfilPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber[700],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Page d'accueil avec grille d'émissions
class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  String _selectedCategory = 'Toutes';
  List<EmissionStreaming> _filteredEmissions = StreamingService.emissions;

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'Toutes') {
        _filteredEmissions = StreamingService.emissions;
      } else {
        _filteredEmissions = StreamingService.getEmissionsByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Navigation vers la page de recherche
            final PageController? controller = 
                context.findAncestorStateOfType<_MapremierePageState>()?._pageController;
            controller?.animateToPage(1, 
                duration: const Duration(milliseconds: 300), 
                curve: Curves.easeInOut);
          },
          tooltip: 'Rechercher',
        ),
        title: const Text(
          'Vos émissions en streaming',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.category, color: Colors.white),
            onPressed: () => _showCategoryFilter(),
            tooltip: 'Catégories',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtre de catégories
          if (_selectedCategory != 'Toutes')
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.amber[50],
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: Colors.amber[700], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Catégorie: $_selectedCategory',
                    style: TextStyle(
                      color: Colors.amber[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _filterByCategory('Toutes'),
                    child: Text(
                      'Effacer',
                      style: TextStyle(color: Colors.amber[700]),
                    ),
                  ),
                ],
              ),
            ),
          // Grille d'émissions
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: partieGrilleImage(emissions: _filteredEmissions),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrer par catégorie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                'Toutes',
                ...StreamingService.categories,
              ].map((category) => FilterChip(
                label: Text(category),
                selected: _selectedCategory == category,
                onSelected: (selected) {
                  _filterByCategory(category);
                  Navigator.pop(context);
                },
                selectedColor: Colors.amber[100],
                checkmarkColor: Colors.amber[700],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Page de recherche d'émissions
class RecherchePage extends StatefulWidget {
  const RecherchePage({super.key});

  @override
  State<RecherchePage> createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  final TextEditingController _searchController = TextEditingController();
  List<EmissionStreaming> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _searchResults = StreamingService.searchEmissions(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: TextField(
          controller: _searchController,
          onChanged: _performSearch,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Rechercher une émission...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: Container(
        color: Colors.grey[50],
        child: _isSearching
            ? _searchResults.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Aucun résultat trouvé',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: partieGrilleImage(emissions: _searchResults),
                  )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Recherchez vos émissions favorites',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Utilisez la barre de recherche ci-dessus',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

/// Page de profil utilisateur
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteEmissions = StreamingService.favoriteEmissions;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Mon Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Paramètres à venir')),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            // Profil utilisateur
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Utilisateur',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${StreamingService.emissions.length} émissions disponibles',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Statistiques
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Favoris', favoriteEmissions.length.toString(), Icons.favorite),
                  _buildStatItem('Catégories', StreamingService.categories.length.toString(), Icons.category),
                  _buildStatItem('Écoutes', '127', Icons.headphones),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Mes favoris
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Mes Favoris',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: favoriteEmissions.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.favorite_border, size: 48, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text(
                                    'Aucun favori pour le moment',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: partieGrilleImage(emissions: favoriteEmissions),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber[700], size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}

/// Grille réactive d'émissions de streaming
/// Utilise ResponsiveGridList pour adapter la grille à différentes tailles d'écran
class partieGrilleImage extends StatelessWidget {
  final List<EmissionStreaming> emissions;
  
  const partieGrilleImage({super.key, required this.emissions});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 160,
      minSpacing: 12,
      children: emissions.map((emission) => IdentificationStreaming(
        emission: emission,
        onFavoriteToggle: () {
          StreamingService.toggleFavorite(emission.id);
        },
      )).toList(),
    );
  }
}

/// Widget réutilisable pour afficher une émission de streaming
/// Affiche l'image, le nom et la chaîne radio avec navigation vers les détails
class IdentificationStreaming extends StatefulWidget {
  final EmissionStreaming emission;
  final VoidCallback? onFavoriteToggle;

  const IdentificationStreaming({
    super.key,
    required this.emission,
    this.onFavoriteToggle,
  });

  @override
  State<IdentificationStreaming> createState() => _IdentificationStreamingState();
}

class _IdentificationStreamingState extends State<IdentificationStreaming> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumStreaming(emission: widget.emission),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image de l'émission avec Hero animation
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Hero(
                        tag: widget.emission.id,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.emission.imageAsset),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.1),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Bouton favori
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                widget.emission.isFavorite = !widget.emission.isFavorite;
                              });
                              widget.onFavoriteToggle?.call();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.emission.isFavorite 
                                        ? 'Ajouté aux favoris' 
                                        : 'Retiré des favoris',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.emission.isFavorite 
                                    ? Icons.favorite 
                                    : Icons.favorite_border,
                                color: widget.emission.isFavorite 
                                    ? Colors.red 
                                    : Colors.grey[600],
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Badge catégorie
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.emission.categorie,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Informations de l'émission
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.emission.nom,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.emission.chaineRadio,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Page de détails d'une émission de streaming
/// Affiche l'image en plein écran avec Hero animation et la liste des diffusions
class AlbumStreaming extends StatefulWidget {
  final EmissionStreaming emission;

  const AlbumStreaming({super.key, required this.emission});

  @override
  State<AlbumStreaming> createState() => _AlbumStreamingState();
}

class _AlbumStreamingState extends State<AlbumStreaming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image avec animation Hero et AppBar transparent
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Image de fond avec Hero animation
                Hero(
                  tag: widget.emission.id,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.emission.imageAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // AppBar transparent avec icônes
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(
                          widget.emission.isFavorite 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: widget.emission.isFavorite 
                              ? Colors.red 
                              : Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.emission.isFavorite = !widget.emission.isFavorite;
                          });
                          StreamingService.toggleFavorite(widget.emission.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                widget.emission.isFavorite 
                                    ? 'Ajouté aux favoris !' 
                                    : 'Retiré des favoris !',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Overlay violet avec informations
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.purple.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            widget.emission.categorie,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.emission.nom,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.emission.chaineRadio,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Section des informations et diffusions
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'À propos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.emission.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    Divider(color: Colors.grey[200], thickness: 1),
                    // Diffusions
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Diffusions récentes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...widget.emission.diffusions.asMap().entries.map(
                            (entry) => _buildDiffusionItem(
                              'Diffusion ${entry.key + 1}', 
                              entry.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit un élément de diffusion avec icône de volume et date
  Widget _buildDiffusionItem(String diffusionName, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Lecture de $diffusionName'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.purple[600],
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        diffusionName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Date: $date',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.volume_up,
                  color: Colors.purple[600],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}