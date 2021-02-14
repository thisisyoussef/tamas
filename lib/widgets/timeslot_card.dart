import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeSlotCard extends StatelessWidget {
  final Timestamp time;
  TimeSlotCard(this.time);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(DateTime.fromMillisecondsSinceEpoch(
                          time.millisecondsSinceEpoch)
                      .hour
                      .toString() +
                  ":00"),
            ),
            height: 70,
            width: 70,
            //color: Colors.white,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(),
              bottom: BorderSide(),
              right: BorderSide(),
              left: BorderSide(),
            )),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
