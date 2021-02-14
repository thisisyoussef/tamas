import 'package:flutter/cupertino.dart';
import 'package:qintar/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService extends ChangeNotifier {
  final key = 'AIzaSyDX17qdVwFzMv1VGg6SezoVhnpQ2aL8zcw';
  static String typeOfPlace = "sports_complex";
  static String searchTerm = '';
  void search(String searchThis) {
    searchTerm = searchThis;
    notifyListeners();
  }

  Future<List<Place>> getPlaces(double lat, double lng) async {
    print("GetPlaces run");
    var response = await http.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=$typeOfPlace&radius=50000&key=$key&keyword=$searchTerm');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
//rankby=distance
