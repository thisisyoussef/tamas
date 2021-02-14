import 'package:cloud_firestore/cloud_firestore.dart';

class Prayer {
  final String Id;
  final String city;
  final String place;
  final Timestamp time;
  final double latitude;
  final double longitude;

  Prayer(
      {this.city,
      this.place,
      this.time,
      this.Id,
      this.latitude,
      this.longitude});
}
