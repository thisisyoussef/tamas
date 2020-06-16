import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Container(
      //height: 400,
      child: SearchMapPlaceWidget(
        apiKey: 'AIzaSyDX17qdVwFzMv1VGg6SezoVhnpQ2aL8zcw',
        location: LatLng(currentPosition.latitude, currentPosition.longitude),
        radius: 50000,
      ),
    );
  }
}
