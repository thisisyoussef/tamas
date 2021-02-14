import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          CircleAvatar(
            backgroundColor: Color(0xFF50B184),
            radius: 80,
            child: Image.asset("assets/images/tamaslogo.png"),
          ),
        ],
      ),
    );
  }
}
