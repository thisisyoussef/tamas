import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ListScreen extends StatefulWidget {
  const ListScreen({
    Key key,
  }) : super(key: key);
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  static bool rebuild = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          MessagesStream(),
        ],
      ),
    );
  }
}


class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final String Id = message.documentID;
          final name = message.data['name'];
          final place = message.data['place'];
          final messageBubble = MessageBubble(
            Id: Id,
            place: place,
            name: name,
          );
          Text('$name from $place');
          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          children: messageBubbles,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ));
      },
      stream: _firestore.collection('upcomingprayers').snapshots(),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    this.Id,
    this.place,
    this.name,
    this.time,
  });
  final String Id;
  final String place;
  final String name;
  var time;
  String easeOfAccess;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 11 / 3,
            child: Card(
              color: easeOfAccess == "easy" ? Colors.green : Colors.white,
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          height: MediaQuery.of(context).size.height / 15,
                          image: NetworkImage(
                              'https://www.osiristours.com/wp-content/uploads/2018/11/201803070520052732-1024x675.jpg'),
                        ),
                      ],
                    ),
                    title: Text(place),
                    subtitle: Text(name),
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
