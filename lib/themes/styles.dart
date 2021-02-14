import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        title: TextStyle(
          // fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
        caption: TextStyle(
          //fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
        subhead: TextStyle(
          // fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
        body1: TextStyle(
          // fontFamily: 'Montserrat',
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Colors.lightGreenAccent,
        ),
        body2: TextStyle(
          //fontFamily: 'Montserrat',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreenAccent,
        ),
      ));
}
