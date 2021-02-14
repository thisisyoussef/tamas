import 'package:flutter/material.dart';
import 'package:qintar/models/time_slot.dart';
import 'package:qintar/widgets/list_card.dart';

class ListScreen extends StatefulWidget {
  List<ListCard> listCards = [];
  ListScreen(this.listCards);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              reverse: true,
              children: widget.listCards,
              //padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            ),
          ),
        ],
      ),
    );
  }
}
