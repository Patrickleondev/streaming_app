import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() {
  runApp(const MonApplication());
}

// Modèle de données pour un contenu de streaming
class StreamingItem {
  final String id;
  final String imageAssetPath;
  final String title;
  final String channel;

  const StreamingItem({
    required this.id,
    required this.imageAssetPath,
    required this.title,
    required this.channel,
  });
}

// Classe principale de l'application
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Streaming',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MapremierePage(),
    );
  }
}

// Page principale avec navigation et logique (Accueil, Recherche, Profil)
class MapremierePage extends StatefulWidget {
  const MapremierePage({super.key});

  @override
  State<MapremierePage> createState() => _MapremierePageState();
}

class _MapremierePageState extends State<MapremierePage> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  // Catalogue de démos basé sur vos images fournies
  final List<StreamingItem> _allItems = const [
    StreamingItem(
      id: 'Parole de Femme',
      imageAssetPath: 'assets/images/parole_de_femme.jpg',
      title: 'Parole de Femme',
      channel: 'Radio 4',
    ),
    StreamingItem(
      id: 'Tendances Mode',
      imageAssetPath: 'assets/images/image.webp',
      title: 'Tendances Mode',
      channel: 'Radio 3',
    ),
    StreamingItem(
      id: 'Enquetes Criminelles',
      imageAssetPath: 'assets/images/image2.webp',
      title: 'Enquêtes Criminelles',
      channel: 'Radio 2',
    ),
    StreamingItem(
      id: 'Match de Foot',
      imageAssetPath: 'assets/images/image3.webp',
      title: 'Match de Foot',
      channel: 'Radio 5',
    ),
    StreamingItem(
      id: 'Streaming Meteo',
      imageAssetPath: 'assets/images/OIP.jpeg',
      title: 'Streaming Météo',
      channel: 'Radio 1',
    ),
    StreamingItem(
      id: 'Que des news',
      imageAssetPath: 'assets/images/R.jpeg',
      title: 'Que des news',
      channel: 'Radio 4',
    ),
  ];

  final Set<String> _favoriteItemIds = <String>{};

  List<StreamingItem> get _filteredItems {
    if (_searchQuery.trim().isEmpty) return _allItems;
    final String queryLower = _searchQuery.toLowerCase();
    return _allItems
        .where((item) =>
            item.title.toLowerCase().contains(queryLower) ||
            item.channel.toLowerCase().contains(queryLower))
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _buildAppBar() {
    switch (_selectedIndex) {
      case 1: // Recherche
        return AppBar(
          title: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Rechercher...',
              border: InputBorder.none,
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          actions: [
            if (_searchQuery.isNotEmpty)
              IconButton(
                tooltip: 'Effacer',
                onPressed: () => setState(() => _searchQuery = ''),
                icon: const Icon(Icons.clear),
              ),
          ],
        );
      case 2: // Profil
        return AppBar(
          title: const Text('Profil'),
        );
      case 0: // Accueil
      default:
        return AppBar(
          title: const Text('Vos émissions en streaming'),
          actions: [
            IconButton(
              tooltip: 'Aller à la recherche',
              onPressed: () => _onItemTapped(1),
              icon: const Icon(Icons.search),
            ),
          ],
        );
    }
  }

  Widget _buildHomeGrid(List<StreamingItem> items) {
    return ResponsiveGridList(
      desiredItemWidth: 150,
      minSpacing: 10,
      children: [
        for (final StreamingItem item in items)
          IdentificationStreaming(
            tagStream: item.id,
            imageStream: item.imageAssetPath,
            NomStream: item.title,
            ChaineRadio: item.channel,
            isFavorite: _favoriteItemIds.contains(item.id),
            onOpenDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumStreaming(
                    tagStream: item.id,
                    imageStream: item.imageAssetPath,
                    NomStream: item.title,
                    ChaineRadio: item.channel,
                    isFavorite: _favoriteItemIds.contains(item.id),
                    onToggleFavorite: () {
                      setState(() {
                        if (_favoriteItemIds.contains(item.id)) {
                          _favoriteItemIds.remove(item.id);
                        } else {
                          _favoriteItemIds.add(item.id);
                        }
                      });
                    },
                  ),
                ),
              );
            },
            onToggleFavorite: () {
              setState(() {
                if (_favoriteItemIds.contains(item.id)) {
                  _favoriteItemIds.remove(item.id);
                } else {
                  _favoriteItemIds.add(item.id);
                }
              });
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // Accueil
          _buildHomeGrid(_allItems),
          // Recherche
          Column(
            children: [
              Expanded(child: _buildHomeGrid(_filteredItems)),
            ],
          ),
          // Profil
          _ProfilePage(favoriteCount: _favoriteItemIds.length),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

class _ProfilePage extends StatelessWidget {
  final int favoriteCount;
  const _ProfilePage({required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 36,
            child: Icon(Icons.person, size: 36),
          ),
          const SizedBox(height: 12),
          const Text(
            'Mon profil',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Favoris: $favoriteCount'),
        ],
      ),
    );
  }
}

// Carte de contenu dans la grille
class IdentificationStreaming extends StatelessWidget {
  final String tagStream;
  final String imageStream;
  final String NomStream;
  final String ChaineRadio;
  final bool isFavorite;
  final VoidCallback onOpenDetails;
  final VoidCallback onToggleFavorite;

  const IdentificationStreaming({
    super.key,
    required this.tagStream,
    required this.imageStream,
    required this.NomStream,
    required this.ChaineRadio,
    required this.isFavorite,
    required this.onOpenDetails,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onOpenDetails,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: tagStream,
                          child: Image.asset(
                            imageStream,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: IconButton(
                          tooltip: isFavorite
                              ? 'Retirer des favoris'
                              : 'Ajouter aux favoris',
                          onPressed: onToggleFavorite,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.8),
                          ),
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[50],
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          NomStream,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          ChaineRadio,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
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

// Page de détails d'une émission
class AlbumStreaming extends StatelessWidget {
  final String tagStream;
  final String imageStream;
  final String NomStream;
  final String ChaineRadio;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const AlbumStreaming({
    super.key,
    required this.tagStream,
    required this.imageStream,
    required this.NomStream,
    required this.ChaineRadio,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(NomStream),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
            onPressed: onToggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image avec animation Hero
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: tagStream,
                    child: Image.asset(
                      imageStream,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Overlay avec titre et chaîne radio
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.65),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NomStream,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ChaineRadio,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Section des diffusions
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Diffusions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: const [
                        _DiffusionItem(title: 'Diffusion 1', date: '2023-01-22'),
                        _DiffusionItem(title: 'Diffusion 2', date: '2023-09-28'),
                        _DiffusionItem(title: 'Diffusion 3', date: '2023-02-02'),
                        _DiffusionItem(title: 'Diffusion 4', date: '2023-01-22'),
                        _DiffusionItem(title: 'Diffusion 5', date: '2023-06-04'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiffusionItem extends StatelessWidget {
  final String title;
  final String date;
  const _DiffusionItem({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.volume_up,
            color: Colors.purple[600],
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title - Date: $date',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
