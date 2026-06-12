import 'package:flutter/material.dart';

import '../services/favoris_service.dart';
import 'meteo_ville_screen.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),

        title: const Padding(
          padding: EdgeInsets.only(top: 40),

          child: Text(
            "Favoris",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
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
              Colors.white,
            ],
          ),
        ),

        // Vérifie si la liste des favoris est vide
        child: FavorisService.favoris.isEmpty

            // Message affiché si aucun favori
            ? const Center(
                child: Text(
                  "Aucun favori",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )

            // Sinon affiche la liste des favoris
            : ListView.builder(
                padding: const EdgeInsets.all(15),

                itemCount: FavorisService.favoris.length,

                itemBuilder: (context, index) {

                  final ville = FavorisService.favoris[index];

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 15),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    color: const Color.fromARGB(255, 255, 255, 255),

                    child: ListTile(

                      contentPadding: const EdgeInsets.all(15),

                      leading: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 35,
                      ),

                      title: Text(
                        ville['nom'],

                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),

                      // Quand on clique sur une ville
                      onTap: () {
                        
                        // Ouvre la page météo de cette ville
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeteoVilleScreen(
                              latitude: ville['lat'],
                              longitude: ville['lon'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}