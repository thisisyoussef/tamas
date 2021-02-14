import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qintar/models/place.dart';
import 'package:qintar/models/prayer_list.dart';
import 'package:qintar/models/selected_location.dart';
import 'package:qintar/services/geolocator_screen.dart';
import 'package:qintar/services/places_service.dart';
import 'screens/map_screen.dart';
import 'models/place.dart';
import 'package:geolocator/geolocator.dart';
import 'screens/onboarding/intro_screen.dart';
import 'screens/onboarding/components/launch_screen.dart';
import 'screens/sign_up/registration_screen.dart';
import 'screens/login_screen.dart';
import 'package:qintar/field_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final locatorService = GeoLocatorService();
    final placesService = PlacesService();
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
        ),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => SelectedLocation(),
        child: MaterialApp(
          initialRoute: MapScreen.id,
          routes: {
            IntroScreen.id: (context) => IntroScreen(),
            MapScreen.id: (context) => MapScreen(),
            LaunchScreen.id: (context) => LaunchScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            FieldDetails.id: (context) => FieldDetails(),
          },
        ),
      ),
    );
  }
}
