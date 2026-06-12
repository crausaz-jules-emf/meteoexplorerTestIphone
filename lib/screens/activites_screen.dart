import 'package:flutter/material.dart';

import 'liste_activites_screen.dart';

class ActivitesScreen extends StatelessWidget {
  const ActivitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Structure principale de la page
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),

        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "Choisir une activité",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),

        foregroundColor: Colors.white,
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

        child: Padding(
          padding: const EdgeInsets.all(20),

          // Affichage vertical des boutons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Bouton Restaurants
              boutonCategorie(
                context,
                "Restaurants",
                Icons.restaurant,
                // Catégorie Geoapify
                "catering.restaurant",
              ),

              const SizedBox(height: 20),

              // Bouton loisirs
              boutonCategorie(
                context,
                "loisirs",
                Icons.theaters,
                "entertainment",
              ),

              const SizedBox(height: 20),

              // Bouton sport
              boutonCategorie(
                context,
                "Sport",
                Icons.sports_soccer,
                "sport",
              ),

              const SizedBox(height: 20),

              // Bouton sites touristiques
              boutonCategorie(
                context,
                "Sites touristiques",
                Icons.location_city,
                "tourism.sights",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction qui crée un bouton de catégorie
  Widget boutonCategorie(
    BuildContext context,
    String titre,
    IconData icon,
    String categorie,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 70,

      child: ElevatedButton(
        // Action quand on clique sur le bouton
        onPressed: () {
          // Ouvre la page ListeActivitesScreen en lui passant la catégorie choisie
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListeActivitesScreen(
                categorie: categorie,
              ),
            ),
          );
        },

        // Style du bouton
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),

        // Contenu du bouton
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, size: 30),

            const SizedBox(width: 15),

            Text(
              titre,
              style: const TextStyle(fontSize: 22 ),
            ),
          ],
        ),
      ),
    );
  }
}