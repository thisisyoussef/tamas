import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class FieldDetails extends StatefulWidget {
  static String id = "field_details";

  FieldDetails(
      {this.Id, this.place, this.city, this.timeSlots, this.amenities});
  final String Id;
  final String place;
  final String city;
  final List<bool> amenities;
  List<Timestamp> timeSlots;

  @override
  _FieldDetailsState createState() => _FieldDetailsState();
}

class _FieldDetailsState extends State<FieldDetails> {
  Map data = {};

  List<String> dateSelectedOpenTimes = [];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    data = ModalRoute.of(context).settings.arguments;
    List fieldAmenities = data['amenities'];
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "field image",
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://www.foreverlawn.com/wp-content/uploads/2019/01/DSC_0018.jpg',
                ),
              ),
            ),
            Center(
              child: Text(
                data['place'].toString(),
                style: TextStyle(
                  color: Color(0xFF50B184),
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                data['city'].toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height / 12,
                child: HorizontalCalendar(
                  date: DateTime.now(),
                  textColor: Colors.black45,
                  backgroundColor: Colors.white,
                  selectedColor: Colors.blue,
                  onDateSelected: (date) {
                    setState(() {
                      //print(date);
                      dateSelectedOpenTimes.clear();
                      for (Timestamp time in data['timeSlots']) {
                        String backendMonth = time.toDate().month.toString();
                        String backendDay = time.toDate().day.toString();
                        String backendYear = time.toDate().year.toString();
                        String frontendMonth = date.toString().substring(5, 7);
                        String frontendDay = date.toString().substring(8);
                        String frontendYear = date.toString().substring(0, 4);
                        print(backendDay);
                        print(frontendDay);
                        print(backendMonth);
                        print(frontendMonth);
                        print(backendYear);
                        print(frontendYear);
                        if (backendDay == frontendDay &&
                            ((backendMonth == frontendMonth) ||
                                ("0" + backendMonth) == frontendMonth) &&
                            backendYear == date.toString().substring(0, 4)) {
                          print("found time");
                          dateSelectedOpenTimes
                              .add(time.toDate().hour.toString());
                        }
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.access_time),
                Text(
                  " Open Times:",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: dateSelectedOpenTimes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 30),
                        child: new Container(
                          child: Center(
                            child: Text(
                              " " + dateSelectedOpenTimes[index] + ":00 ",
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF50B184)),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFF50B184),
                              ),
                              bottom: BorderSide(
                                color: Color(0xFF50B184),
                              ),
                              right: BorderSide(
                                color: Color(0xFF50B184),
                              ),
                              left: BorderSide(
                                color: Color(0xFF50B184),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.store),
                    Text(
                      " Amenities:",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    fieldAmenities != null
                        ? Icon(
                            Icons.play_circle_outline,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.play_circle_outline,
                            color: Colors.grey,
                          )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
