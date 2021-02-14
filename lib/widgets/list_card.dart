import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qintar/models/time_slot.dart';
import 'package:qintar/widgets/timeslot_card.dart';
import 'package:qintar/field_details.dart';

class ListCard extends StatefulWidget {
  ListCard({
    this.Id,
    this.place,
    this.city,
    this.timeSlots,
    this.amenities,
  });
  final String Id;
  final String place;
  final String city;
  final List<bool> amenities;
  List<Timestamp> timeSlots;
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  List<TimeSlotCard> timeSlotCards = [];
  String easeOfAccess;
  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < widget.timeSlots.length; i++) {
      print(i);
      timeSlotCards.add(TimeSlotCard(widget.timeSlots[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FieldDetails instance = FieldDetails(
      place: widget.place,
      city: widget.city,
      Id: widget.Id,
      timeSlots: widget.timeSlots,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: Card(
            color: easeOfAccess == "easy" ? Colors.green : Colors.white,
            // elevation: 7,
            //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, FieldDetails.id,
                        arguments: {
                          'place': instance.place,
                          'Id': instance.Id,
                          'city': instance.city,
                          'timeSlots': instance.timeSlots,
                          'amenities': instance.amenities,
                        });
                  },
                  leading: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Hero(
                          tag: "field image",
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Image.network(
                              'https://www.foreverlawn.com/wp-content/uploads/2019/01/DSC_0018.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: widget.place != null
                      ? Text(widget.place)
                      : Text("place is null"),
                  subtitle: widget.city != null
                      ? Text(widget.city)
                      : Text("name is null"),
                  isThreeLine: true,
                  trailing: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      RaisedButton(
                        textColor: Colors.redAccent,
                        disabledColor: Colors.grey,
                        shape: CircleBorder(),
                        color: Colors.green,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            "GO",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: ListView(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    children: timeSlotCards,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
