import 'package:flutter/material.dart';
import 'registration_screen.dart';

class EmailInput extends StatefulWidget {
  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "and Email?",
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
                initialValue: RegistrationScreen.userDetails.email,
                decoration: InputDecoration(labelText: "Email"),
                style: TextStyle(),
                onChanged: (email) {
                  RegistrationScreen.userDetails.email = email;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
