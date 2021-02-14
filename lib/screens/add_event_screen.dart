import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qintar/widgets/new_search_bar.dart';
import 'package:qintar/models/selected_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qintar/models/prayer.dart';

import 'onboarding/intro_screen.dart';

Prayer newPrayer;
final _firestore = Firestore.instance;

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String name;

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedLocation>(
      builder: (BuildContext context, SelectedLocation value, Widget child) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Searchbar(),
              Container(
                height: MediaQuery.of(context).size.height * 1 / 10,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    value.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                color: Colors.green[100],
              ),
              Container(
                color: Colors.green[100],
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green[900]),
                  decoration: InputDecoration(
                    hintText: "Enter name",
                  ),
                  onChanged: (newName) {
                    name = newName;
                    print(name);
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1 / 10,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    value.position.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                color: Colors.green[100],
              ),
              RaisedButton(onPressed: () {
                print(name);
                _firestore.collection('upcomingprayers').add({
                  'name': name,
                  'place': value.name,
                  'latitude': value.positionLatitude,
                  'longitude': value.positionLongitude,
                });
                print(("done"));
              })
            ],
          ),
        );
      },
    );
  }
}
