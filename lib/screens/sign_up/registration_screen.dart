import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qintar/screens/map_screen.dart';
import 'package:qintar/screens/onboarding/components/rounded_button.dart';
import 'package:qintar/screens/sign_up/email_input.dart';
import 'package:qintar/screens/sign_up/name_input.dart';
import 'package:qintar/data/new_user_details.dart';
import 'package:qintar/screens/sign_up/password_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  static NewUserDetails userDetails = NewUserDetails();
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TabController _tabController;
  static const tabs = <Tab>[
    Tab(
      child: Icon(
        Icons.map,
        color: Colors.green,
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.map,
        color: Colors.green,
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.map,
        color: Colors.green,
        size: 30,
      ),
    ),
  ];
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF50B184), Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: TabBarView(
                controller: _tabController,
                children: <Widget>[NameInput(), EmailInput(), PasswordInput()]),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width - 80,
            child: FloatingActionButton(
              onPressed: () async {
                if (_tabController.index == 2) {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: RegistrationScreen.userDetails.email,
                        password: RegistrationScreen.userDetails.password);
                    setState(() {
                      showSpinner = false;
                    });
                    if (newUser != null) {
                      _firestore
                          .collection('users')
                          .document(newUser.user.uid)
                          .setData(({
                            'uid': newUser.user.uid,
                            'email': RegistrationScreen.userDetails.email,
                            'First Name':
                                RegistrationScreen.userDetails.firstName,
                            'Last Name': RegistrationScreen.userDetails.lastName
                          }));
                      //   Navigator.pop(context);

/*
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 700),
                          transitionsBuilder:
                              (context, animation, secAnimation, child) {
                            animation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.elasticInOut);
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                              alignment: Alignment.bottomCenter,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secAnimation) {
                            return MapScreen();
                          },
                        ),
                      );
*/

                    }
                  } catch (e) {
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                  }
                }
                setState(() {
                  _tabController.index++;
                });
              },
              backgroundColor: Colors.white,
              child: Icon(
                _tabController.index == 2 ? Icons.done : Icons.navigate_next,
                color: Color(0xFF50B184),
              ),
            ),
          ),
          Visibility(
            visible: _tabController.index > 0,
            child: Positioned(
              bottom: 20,
              right: MediaQuery.of(context).size.width - 80,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _tabController.index -= 1;
                  });
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.navigate_before,
                  color: Color(0xFF50B184),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
