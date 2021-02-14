import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qintar/data/onboard_page_details.dart';
import 'package:qintar/themes/styles.dart';
import 'package:qintar/screens/onboarding/components/onboard_page.dart';

class IntroScreen extends StatelessWidget {
  static String id = "intro_screen";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: PageView.builder(
                  itemCount: onboardData.length,
                  itemBuilder: (context, index) {
                    return OnboardPage(
                      pageModel: onboardData[index],
                    );
                  },
                ),
              ),
              Positioned(
                child: Container(
                  width: double.infinity,
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
