import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/favoris_service.dart';

class MeteoVilleScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MeteoVilleScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MeteoVilleScreen> createState() => _MeteoVilleScreenState();
}

class _MeteoVilleScreenState extends State<MeteoVilleScreen> {
  // Variables météo
  String temperature = "--";
  String vent = "--";
  String humidite = "--";
  String visibilite = "--";
  String lieu = "--";

  // Vérifie si la ville est en favori
  bool estFavori = false;

  @override
  void initState() {
    super.initState();
    chargerMeteo();
  }

  Future<void> chargerMeteo() async {
    try {
      // Récupère les données météo grâce aux coordonnées 
      final data = await WeatherService.getWeather(
        widget.latitude,
        widget.longitude,
      );


      setState(() {
        temperature = "${data['main']['temp']}";
        vent = "${data['wind']['speed']} km/h";
        humidite = "${data['main']['humidity']}%";

        visibilite = "${data['visibility'] / 1000} km";

        lieu = data['name'];

        // Vérifie si la ville est déjà dans les favoris
        estFavori = FavorisService.favoris.any((ville) {
          return ville['lat'] == widget.latitude &&
              ville['lon'] == widget.longitude;
        });

      });
    } catch (e) {
      setState(() {
        temperature = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),
        elevation: 0,
        centerTitle: true,

        title: Padding(
          padding: const EdgeInsets.only(top: 40),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                lieu,
                style: TextStyle(
                  fontSize: 40,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
        // Bouton favoris
        actions: [
          IconButton(
            onPressed: () {
              // Change l'état du favori
              setState(() {
                estFavori = !estFavori;

                // Ajoute la ville aux favoris
                if (estFavori) {
                  FavorisService.favoris.add({
                    "nom": lieu,
                    "lat": widget.latitude,
                    "lon": widget.longitude,
                  });
                } else {
                  // Supprime la ville des favoris
                  FavorisService.favoris.removeWhere((ville) {
                    return ville['lat'] == widget.latitude &&
                        ville['lon'] == widget.longitude;
                  });
                }
              });
            },

            icon: Icon(
              estFavori ? Icons.favorite : Icons.favorite_border,

              color: estFavori ? Colors.red : Colors.black,
            ),
          ),
        ],
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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // TEMPÉRATURE
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Text(
                    "°C",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),

            // INFOS METÉO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // Vent
                SizedBox(
                  width: 120,
                  child: Column(
                    children: [
                      const Icon(Icons.air, size: 35),
                      const SizedBox(height: 10),
                      Text(vent),
                    ],
                  ),
                ),

                // Humidité
                SizedBox(
                  width: 120,
                  child: Column(
                    children: [
                      const Icon(Icons.water_drop, size: 35),
                      const SizedBox(height: 10),
                      Text(humidite),
                    ],
                  ),
                ),

                // Visibilité
                SizedBox(
                  width: 120,
                  child: Column(
                    children: [
                      const Icon(Icons.remove_red_eye, size: 35),
                      const SizedBox(height: 10),
                      Text(visibilite),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
