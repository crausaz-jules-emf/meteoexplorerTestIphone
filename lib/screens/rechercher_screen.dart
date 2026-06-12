import 'package:flutter/material.dart';

import '../services/weather_service.dart';

import 'meteo_ville_screen.dart';

class RechercherScreen extends StatefulWidget {
  const RechercherScreen({super.key});

  @override
  State<RechercherScreen> createState() => _RechercherScreenState();
}

class _RechercherScreenState extends State<RechercherScreen> {
  // Controller qui récupère le texte écrit dans le TextField
  final TextEditingController villeController = TextEditingController();

  // Fonction appelée quand on clique sur "Rechercher"
  void rechercherVille() async {
    // Récupère le texte écrit par l'utilisateur
    String ville = villeController.text;  

    if (ville.isEmpty) {
      return;
    }

    try {
      // Appelle l'API pour récupérer les coordonnées
      final data = await WeatherService.getCoordonnee(ville);

      double lat = data['lat'];
      double lon = data['lon'];

      // Ouvre la page météo de la ville recherchée
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeteoVilleScreen(latitude: lat, longitude: lon),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Structure principale de la page
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 150, 250),
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),

        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "Rechercher une ville",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 39, 150, 250),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Champ de texte pour écrire une ville
              TextField(
                controller: villeController,

                decoration: const InputDecoration(
                  hintText: "Entrer une ville",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),

                  filled: true,
                  fillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Bouton rechercher
              ElevatedButton(
                // Lance la fonction rechercherVille()
                onPressed: rechercherVille,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 248, 255),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 5,
                  ),
                ),

                child: const Text(
                  "Rechercher",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
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
