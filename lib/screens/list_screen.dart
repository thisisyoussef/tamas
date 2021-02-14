import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qintar/widgets/list_card.dart';

final _firestore = Firestore.instance;

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
              reverse: true,
              children: widget.listCards,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
