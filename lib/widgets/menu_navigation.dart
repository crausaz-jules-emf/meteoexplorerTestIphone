import 'package:flutter/material.dart';

class MenuNavigation extends StatelessWidget {

  final int indexActuel;
  final Function(int) quandOnClique;

  const MenuNavigation({
    super.key,
    required this.indexActuel,
    required this.quandOnClique,
  });

  @override
  Widget build(BuildContext context) {

    return Theme(
      // Modifie le thème du BottomNavigationBar
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),

      child: Container(
        
        // Bordure noire en haut du menu
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),

        child: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,

          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          currentIndex: indexActuel,

          selectedItemColor: const Color.fromARGB(255, 12, 89, 207),
          unselectedItemColor: Colors.black,

          // Lance la fonction quand un bouton du menu est cliqué et envoie automatiquement son index
          onTap: quandOnClique,

          // Liste des boutons du menu 
          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Rechercher",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favoris",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk),
              label: "Activités",
            ),

          ],
        ),
      ),
    );
  }
}