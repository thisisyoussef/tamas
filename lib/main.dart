import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qintar/models/place.dart';
import 'package:qintar/services/geolocator_screen.dart';
import 'package:qintar/services/places_service.dart';
import 'screens/map_screen.dart';
import 'models/place.dart';
import 'package:geolocator/geolocator.dart';

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
        })
      ],
      child: ChangeNotifierProvider(
        create: (context) => PlacesService(),
        child: MaterialApp(
          initialRoute: MapScreen.id,
          routes: {
            MapScreen.id: (context) => MapScreen(),
          },
        ),
      ),
    );
  }
}
