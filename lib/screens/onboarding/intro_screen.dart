import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qintar/data/onboard_page_details.dart';
import 'package:qintar/themes/styles.dart';
import 'package:qintar/screens/onboarding/components/onboard_page.dart';
import 'package:qintar/screens/onboarding/components/rounded_button.dart';
import 'package:qintar/screens/sign_up/registration_screen.dart';

class IntroScreen extends StatefulWidget {
  static String id = "intro_screen";
  int selectedPage = 0;

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Timer timer;
  void swipeScreen() {
    print("swiping");
    if (widget.selectedPage < 2) {
      setState(() {
        widget.selectedPage++;
        print(widget.selectedPage);
        print("gate 1");
      });
    } else {
      print("Gate 2");
      widget.selectedPage = 0;
    }
    print("Set state");
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => swipeScreen());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: PageView.builder(
                    controller: PageController(
                        initialPage: widget.selectedPage,
                        keepPage: false,
                        viewportFraction: 1),
                    itemCount: onboardData.length,
                    itemBuilder: (context, index) {
                      return OnboardPage(
                        pageModel: onboardData[index],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    //width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1 / 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Hero(
                            tag: "logo",
                            child: Image.asset("assets/images/tamaslogo.png",
                                height: 50),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18, left: 5),
                            child: Text(
                              "Tamas",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width - 160),
                            child: Text(
                              "Skip",
                              style: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  //left: MediaQuery.of(context).size.width / 4,
                  child: Column(
                    children: <Widget>[
                      RoundedButton(
                        color: Color(0xFF50B184),
                        title: "Sign Up",
                        OnPressed: () {
                          print("pressed button");
                          Navigator.popAndPushNamed(
                              context, RegistrationScreen.id);
                        },
                      ),
                      Text(
                        "I already have an account",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
