import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qintar/models/location.dart';

class Prayer {
  final String Id;
  final String name;
  final String place;
  final Timestamp time;
  final double latitude;
  final double longitude;

  Prayer(
      {this.name,
      this.place,
      this.time,
      this.Id,
      this.latitude,
      this.longitude});
}
