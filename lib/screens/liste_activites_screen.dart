import 'package:flutter/material.dart';

import '../services/activites_service.dart';
import '../services/localisation_service.dart';

// Permet de copier du texte dans le presse-papiers
import 'package:flutter/services.dart';

class ListeActivitesScreen extends StatefulWidget {
  final String categorie;

  const ListeActivitesScreen({super.key, required this.categorie});

  @override
  State<ListeActivitesScreen> createState() => _ListeActivitesScreenState();
}

class _ListeActivitesScreenState extends State<ListeActivitesScreen> {
  // Liste qui contiendra toutes les activités récupérées
  List activites = [];

  @override
  void initState() {
    super.initState();
    chargerActivites();
  }

  Future<void> chargerActivites() async {
    // Récupère la position actuelle du téléphone
    final position = await getCurrentPosition();

    // Appelle le service avec :
    // latitude + longitude + catégorie choisie
    final data = await ActivitesService.getActivites(
      position.latitude,
      position.longitude,
      widget.categorie,
    );

    // Met à jour la liste des activités
    setState(() {
      activites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activités"),
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),
      ),
      backgroundColor: Colors.white,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 39, 150, 250), Colors.white],
          ),
        ),

        // Si aucune activité trouvée
        child: activites.isEmpty
            ? const Center(
                child: Text(
                  "Aucune activité trouvée",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            // Sinon affiche la liste des activités
            : ListView.builder(
                padding: const EdgeInsets.all(15),

                itemCount: activites.length,

                itemBuilder: (context, index) {
                  final activite = activites[index];

                  final props = activite['properties'];

                  // Adresse complète
                  final adresse = props['formatted'] ?? "Adresse inconnue";

                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 15),
                    color: const Color.fromARGB(255, 255, 255, 255),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Ligne avec icône + nom
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Color.fromARGB(255, 39, 150, 250),
                                size: 30,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  props['name'] ?? "Sans nom",

                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Text(adresse, style: const TextStyle(fontSize: 16)),

                          const SizedBox(height: 15),
                          
                          // Bouton copier
                          Align(
                            alignment: Alignment.centerRight,

                            child: ElevatedButton.icon(
                              // Quand on clique sur le bouton
                              onPressed: () async {
                                // Copie l'adresse
                                await Clipboard.setData(
                                  ClipboardData(text: adresse),
                                );

                                // Petit message affiché en bas
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Adresse copiée"),
                                  ),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 39, 150, 250),
                                foregroundColor: Colors.white,
                              ),

                              icon: const Icon(Icons.copy),

                              label: const Text("Copier"),
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
