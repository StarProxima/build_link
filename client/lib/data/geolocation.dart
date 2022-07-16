import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

Future<LatLng?> getCurrentCoord() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return null;
  }
  Position pos = await Geolocator.getCurrentPosition();
  return LatLng(pos.latitude, pos.longitude);
}
