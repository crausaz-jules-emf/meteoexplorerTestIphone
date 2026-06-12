import 'package:flutter/material.dart';

import '../services/localisation_service.dart';
import '../services/weather_service.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  // Variables contenant les données météo affichées à l'écran
  String temperature = "--";
  String vent = "--";
  String humidite = "--";
  String visibilite = "--";
  String lieu = "--";

  @override
  void initState() {
    super.initState();
    chargerMeteo();
  }

  Future<void> chargerMeteo() async {
    try {
      // Récupère la position actuelle de l'utilisateur
      final position = await getCurrentPosition();
      // Appelle l'API météo avec latitude + longitude
      final data = await WeatherService.getWeather(
        position.latitude,
        position.longitude,
      );

      // Met à jour les données affichées à l'écran
      setState(() {
        temperature = "${data['main']['temp']}";
        vent = "${data['wind']['speed']} km/h";
        humidite = "${data['main']['humidity']}%";


        visibilite = "${data['visibility'] / 1000} km";

        lieu = data['name'];
      });

    } catch (e) {
      setState(() {
        temperature = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Structure principale de la page
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: const Color.fromARGB(255, 39, 150, 250),
        elevation: 0,
        centerTitle: true,

        title: Padding(
          padding: const EdgeInsets.only(top: 40),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // Ligne contenant :
              // icône localisation + texte
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 30),

                  SizedBox(width: 8),

                  Text(
                    "Ma position",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
              // Nom de la ville actuelle
              Text(lieu, style: TextStyle(fontSize: 20, color: const Color.fromARGB(240, 255, 255, 255))),
            ],
          ),
        ),
      ),

      // Corps principal de la page
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
                // Température actuellef
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
                )
              ],
            ),

            const SizedBox(height: 100),

            // INFOS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // Bloc vent
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

                SizedBox(
                  // Bloc humidité
                  width: 120,
                  child: Column(
                    children: [
                      const Icon(Icons.water_drop, size: 35),
                      const SizedBox(height: 10),
                      Text(humidite),
                    ],
                  ),
                ),

                SizedBox(
                  // Bloc visibilité
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
