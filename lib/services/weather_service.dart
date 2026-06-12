import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {

  /*
    Cette fonction récupère la météo grâce à :
    - une latitude
    - une longitude
  */
  static Future<Map<String, dynamic>> getWeather(
    double lat,
    double lon,
  ) async {

    const apiKey = "b47d0e04c50d735b0734cc8001c437bc";

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=fr",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erreur API météo");
    }
  }

  /*
    Cette fonction transforme un nom de ville
    en latitude et longitude.

    Exemple :
    "Paris" -> lat + lon
  */
  static Future<Map<String, dynamic>> getCoordonnee(
    String city,
  ) async {

    const apiKey = "b47d0e04c50d735b0734cc8001c437bc";

    final url = Uri.parse(
      "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data[0];
      } else {
        throw Exception("Ville non trouvée");
      }
    } else {
      throw Exception("Erreur API géocodage");
    }
  }
}