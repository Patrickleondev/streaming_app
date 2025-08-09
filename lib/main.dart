import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

void main() {
  runApp(const MonApplication());
}

// Classe principale de l'application
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Streaming',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MapremierePage(),
    );
  }
}

// Page principale avec navigation
class MapremierePage extends StatefulWidget {
  const MapremierePage({super.key});

  @override
  State<MapremierePage> createState() => _MapremierePageState();
}

class _MapremierePageState extends State<MapremierePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Action de recherche
          },
        ),
        title: const Text('Vos émissions en streaming'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // Action de liste
            },
          ),
        ],
      ),
      body: const Center(
        child: partieGrilleImage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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

// Widget pour afficher une émission de streaming
class IdentificationStreaming extends StatelessWidget {
  final String tagStream;
  final String imageStream;
  final String NomStream;
  final String ChaineRadio;

  const IdentificationStreaming({
    super.key,
    required this.tagStream,
    required this.imageStream,
    required this.NomStream,
    required this.ChaineRadio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumStreaming(
                  tagStream: tagStream,
                  imageStream: imageStream,
                  NomStream: NomStream,
                  ChaineRadio: ChaineRadio,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: tagStream,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageStream),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[200],
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
                          color: Colors.grey[600],
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
    );
  }
}

// Grille d'images réactive
class partieGrilleImage extends StatelessWidget {
  const partieGrilleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      desiredItemWidth: 150,
      minSpacing: 10,
      children: [
        IdentificationStreaming(
          tagStream: 'Parole de Femme',
          imageStream: 'assets/images/parole_de_femme.jpg',
          NomStream: 'Parole de Femme',
          ChaineRadio: 'Radio 4',
        ),
        IdentificationStreaming(
          tagStream: 'Tendances Mode',
          imageStream: 'assets/images/image.webp',
          NomStream: 'Tendances Mode',
          ChaineRadio: 'Radio 3',
        ),
        IdentificationStreaming(
          tagStream: 'Enquetes Criminelles',
          imageStream: 'assets/images/image2.webp',
          NomStream: 'Enquêtes Criminelles',
          ChaineRadio: 'Radio 2',
        ),
        IdentificationStreaming(
          tagStream: 'Match de Foot',
          imageStream: 'assets/images/image3.webp',
          NomStream: 'Match de Foot',
          ChaineRadio: 'Radio 5',
        ),
        IdentificationStreaming(
          tagStream: 'Streaming Meteo',
          imageStream: 'assets/images/OIP.jpeg',
          NomStream: 'Streaming Météo',
          ChaineRadio: 'Radio 1',
        ),
        IdentificationStreaming(
          tagStream: 'Que des news',
          imageStream: 'assets/images/R.jpeg',
          NomStream: 'Que des news',
          ChaineRadio: 'Radio 4',
        ),
      ],
    );
  }
}

// Page de détails d'une émission
class AlbumStreaming extends StatelessWidget {
  final String tagStream;
  final String imageStream;
  final String NomStream;
  final String ChaineRadio;

  const AlbumStreaming({
    super.key,
    required this.tagStream,
    required this.imageStream,
    required this.NomStream,
    required this.ChaineRadio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Action favoris
            },
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
                Hero(
                  tag: tagStream,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageStream),
                        fit: BoxFit.cover,
                      ),
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
                          Colors.purple.withOpacity(0.8),
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ChaineRadio,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildDiffusionItem('Diffusion 1', '2023-1-22'),
                        _buildDiffusionItem('Diffusion 2', '2023-9-28'),
                        _buildDiffusionItem('Diffusion 3', '2023-2-02'),
                        _buildDiffusionItem('Diffusion 4', '2023-1-22'),
                        _buildDiffusionItem('Diffusion 5', '2023-6-04'),
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

  Widget _buildDiffusionItem(String diffusionName, String date) {
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
              '$diffusionName - Date: $date',
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
