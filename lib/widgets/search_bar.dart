import 'package:flutter/material.dart';
import 'package:qintar/screens/add_screen.dart';
import 'package:qintar/screens/map_screen.dart';
import 'package:qintar/services/places_service.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => new _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), top: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      leading: Center(
        child: AnimatedIcon(
          icon: AnimatedIcons.search_ellipsis,
          color: Colors.grey,
          progress: MapScreenState.iconController,
        ),
      ),
      title: TextField(
        //enabled: _MapScreenState.isSearching,
        onTap: () {
          setState(() {
            MapScreenState.isSearching = true;
          });
          MapScreenState.iconController.forward();
        },
        onChanged: (inputText) {
          setState(() {});
          print(inputText);
          Provider.of<PlacesService>(context).search(inputText);
          //AddScreen().update();
        },
      ),
    );
  }
}
