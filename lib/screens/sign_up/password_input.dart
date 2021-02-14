import 'package:flutter/material.dart';
import 'registration_screen.dart';

bool obscureText = true;

class PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text(
                "Add a password and you're done!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: TextFormField(
                showCursor: false,
                obscureText: obscureText,
                decoration: InputDecoration(
                  suffix: FlatButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Text(
                        obscureText ? "Show" : "Hide",
                      )),
                  labelText: "Password",
                ),
                style: TextStyle(),
                onChanged: (password) {
                  RegistrationScreen.userDetails.password = password;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
