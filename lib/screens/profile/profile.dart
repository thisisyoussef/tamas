import 'dart:math';
import 'package:qintar/screens/sign_up/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qintar/screens/onboarding/components/rounded_button.dart';
import 'dart:io';
import 'package:qintar/screens/login_screen.dart';
import 'package:qintar/screens/sign_up/registration_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String name;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        //var firebaseUser = await FirebaseAuth.instance.currentUser();
        _firestore
            .collection("users")
            .document(loggedInUser.uid)
            .get()
            .then((value) {
          name = (value.data["First Name"]) + " " + (value.data["Last Name"]);
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
          name != null && loggedInUser != null
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.green, fontSize: 30),
                      ),
                    ),
                    RoundedButton(
                        title: "Log Out",
                        color: Colors.green,
                        OnPressed: () {
                          setState(() {
                            _auth.signOut();
                            loggedInUser = null;
                            name = null;
                          });
                        }),
                  ],
                )
              : Column(
                  children: <Widget>[
                    RoundedButton(
                        title: "Sign Up",
                        color: Colors.green,
                        OnPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        }),
                    RoundedButton(
                        title: "Log in",
                        color: Colors.green,
                        OnPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        })
                  ],
                ),
        ],
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
