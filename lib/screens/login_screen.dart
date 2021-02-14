import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = "login_screen";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF50B184), Colors.white]),
      ),
    );
  }
}
