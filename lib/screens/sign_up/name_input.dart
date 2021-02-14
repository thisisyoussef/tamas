import 'package:flutter/material.dart';
import 'registration_screen.dart';

class NameInput extends StatefulWidget {
  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "Whats your name?",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: TextFormField(
                initialValue: RegistrationScreen.userDetails.firstName,
                decoration: InputDecoration(labelText: "First Name"),
                style: TextStyle(),
                onChanged: (firstName) {
                  RegistrationScreen.userDetails.firstName = firstName;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 45.0, vertical: 30),
              child: TextFormField(
                initialValue: RegistrationScreen.userDetails.lastName,
                decoration: InputDecoration(
                  labelText: "Last Name",
                ),
                style: TextStyle(),
                onChanged: (lastName) {
                  RegistrationScreen.userDetails.lastName = lastName;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
