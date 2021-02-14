import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:geopoint/geopoint.dart';

class SelectedLocation extends ChangeNotifier {
  LatLng position;
  GeoPoint positionGeoPoint;
  double positionLatitude;
  double positionLongitude;
  String name = "null";
  Image image;
  void changeName(String newName) {
    name = newName;
    notifyListeners();
  }

  void changeImage() {}

  void changePosition(LatLng newPosition) {
    position = newPosition;
    try {
      positionLatitude = position.latitude;
      positionLongitude = position.longitude;
    } catch (e) {}
  }
}
