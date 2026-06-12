import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // Si la localisation est désactivée → erreur
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();

  // Si l'utilisateur n'a pas encore accepté/refusé
  if (permission == LocationPermission.denied) {
    // Demande la permission
    permission = await Geolocator.requestPermission();
    // Si l'utilisateur refuse → erreur
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  // Si l'utilisateur a refusé définitivement
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // Retourne la position actuelle du téléphone
  return await Geolocator.getCurrentPosition();
}