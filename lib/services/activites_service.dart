import 'dart:convert';
import 'package:http/http.dart' as http;

class ActivitesService {

  static Future<List<dynamic>> getActivites(
    double lat,
    double lon,
    String categorie,
  ) async {

    const apiKey = "32b7dca69d2c4fbc9c38b1bf147fb22b";

    // Création de l'URL pour la requête API
    final url = Uri.parse(
      "https://api.geoapify.com/v2/places?"
      "categories=$categorie"
      "&filter=circle:$lon,$lat,3000"
      "&bias=proximity:$lon,$lat"
      "&limit=30"
      "&apiKey=$apiKey",
    );

    // Envoie la requête HTTP à l'API
    final response = await http.get(url);

    // Vérifie si la requête a fonctionné
    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      return data['features'];

    } else {
      throw Exception("Erreur API activités");
    }
  }
}