import 'dart:collection';

import 'package:qintar/screens/map_screen.dart';

import 'prayer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PrayerData extends ChangeNotifier {
  final _firestore = Firestore.instance;
  var messages;
  final Set<Marker> markers = HashSet<Marker>();

  List<Prayer> prayers = [];
  Widget build(BuildContext context) {
    print("gate2");
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        messages = snapshot.data.documents.reversed;
        print("gate3");
        addPrayers();
        print("gate4");
        return null;
      },
      stream: _firestore.collection('upcomingprayers').snapshots(),
    );
  }

  void addPrayers() {
    print("gate1");
    print(messages);
    for (var message in messages) {
      final String Id = message.documentID;
      final name = message.data['name'];
      final place = message.data['place'];
      final double latitude = double.parse(message.data['latitude']);
      final double longitude = double.parse(message.data['longitude']);
      final prayer = Prayer(
        Id: Id,
        place: place,
        city: name,
        latitude: latitude,
        longitude: longitude,
      );
      prayers.add(prayer);
      latitude != null && longitude != null
          ? markers.add(
              Marker(
                infoWindow: InfoWindow(title: name),
                markerId: MarkerId(Id),
                position: LatLng(latitude, longitude),
              ),
            )
          : null;
    }
    notifyListeners();
  }
}
