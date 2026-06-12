import 'package:flutter/material.dart';

// Importation du menu de navigation
import 'widgets/menu_navigation.dart';

// Importation des différentes pages de l'application
import 'screens/accueil_screen.dart';
import 'screens/rechercher_screen.dart';
import 'screens/favoris_screen.dart';
import 'screens/activites_screen.dart';

// Liste de toutes les pages de l'application
/*
  0 = Accueil
  1 = Rechercher
  2 = Favoris
  3 = Activités
*/
final List<Widget> listeDesPages = [
  AccueilScreen(),
  RechercherScreen(),
  FavorisScreen(),
  ActivitesScreen(),
];

void main() {

  // Lance l'application Flutter
  runApp(const ApplicationMeteoExplorer());
}

// Application principale
class ApplicationMeteoExplorer extends StatelessWidget {
  const ApplicationMeteoExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp contient toute l'application
    return MaterialApp(
      // Première page affichée
      home: const PagePrincipale(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Page principale avec navigation
class PagePrincipale extends StatefulWidget {
  const PagePrincipale({super.key});

  @override
  State<PagePrincipale> createState() => _PagePrincipaleState();
}

class _PagePrincipaleState extends State<PagePrincipale> {
  // Variable qui stocke l'index de la page actuelle
  int indexPageActuelle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Affiche la page correspondant à l'index actuel
      body: listeDesPages[indexPageActuelle],

      // Barre de navigation du bas
      bottomNavigationBar: MenuNavigation(
        // Envoie l'index actuel au menu
        indexActuel: indexPageActuelle,

        quandOnClique: (indexClique) {
          // Met à jour l'écran avec la page correspondant à l'index cliqué
          setState(() {
            indexPageActuelle = indexClique;
          });
        },
      ),
    );
  }
}
