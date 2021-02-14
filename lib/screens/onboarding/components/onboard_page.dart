import 'package:flutter/material.dart';
import 'package:qintar/models/onboard_page_model.dart';
import 'package:qintar/screens/onboarding/components/rounded_button.dart';
import 'package:qintar/screens/sign_up/registration_screen.dart';

class OnboardPage extends StatefulWidget {
  final OnboardPageModel pageModel;
  const OnboardPage({Key key, this.pageModel});
  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: (widget.pageModel.pageNumber == 2)
              ? MediaQuery.of(context).size.height * 5 / 6
              : MediaQuery.of(context).size.height,
          color: widget.pageModel.primeColor.withOpacity(1.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Image.asset(widget.pageModel.imagePath),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  widget.pageModel.caption,
                  style: TextStyle(
                    fontSize: 24,
                    color: widget.pageModel.accentColor.withOpacity(0.8),
                    letterSpacing: 1,
                    //fontStyle: FontStyle.normal
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  widget.pageModel.subhead,
                  style: TextStyle(
                    fontSize: 40,
                    color: widget.pageModel.accentColor.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    // fontStyle: FontStyle.normal
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  widget.pageModel.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: widget.pageModel.accentColor.withOpacity(0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
