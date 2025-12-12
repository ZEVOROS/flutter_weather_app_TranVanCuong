import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<bool> _checkPermission() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return false;
    LocationPermission p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
      if (p == LocationPermission.denied) return false;
    }
    if (p == LocationPermission.deniedForever) return false;
    return true;
  }

  Future<Position> getCurrentPosition() async {
    final ok = await _checkPermission();
    if (!ok) throw Exception('Location permission denied');
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getCityFromCoordinates(double lat, double lon) async {
    final places = await placemarkFromCoordinates(lat, lon);
    return places.isNotEmpty ? (places[0].locality ?? '') : '';
  }
}
