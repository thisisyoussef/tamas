import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSlot {
  Timestamp time;
  bool isBooked;
  TimeSlot({time, isBooked});
}
