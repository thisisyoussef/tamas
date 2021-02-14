import 'dart:ui';
import 'package:qintar/models/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
      Color(0xFFFFFFFF),
      Color(0xFF50B184),
      Color(0xFF8DA8FF),
      0,
      "assets/images/soccerstadium.png",
      "Reserve",
      "Reserve a field at the time and place of your choice in a few seconds",
      "Your Field",
      false),
  OnboardPageModel(
      Color(0xFFFFFFFF),
      Color(0xFF50B184),
      Color(0xFF376F92),
      1,
      "assets/images/findplayers.png",
      "Find",
      "Find the right players for your team",
      "Your Players",
      false),
  OnboardPageModel(Color(0xFFFFFFFF), Color(0xFF50B184), Color(0xFFFFFFFF), 2,
      "assets/images/playerkickingball.png", "Play", "", "Your Game", true),
];
