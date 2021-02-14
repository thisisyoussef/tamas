import 'package:geolocator/geolocator.dart';

Position _currentPosition;

class GeoLocatorService {
  Future<Position> getLocation() async {
    var geolocator = Geolocator();
    return await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);
  }
}
