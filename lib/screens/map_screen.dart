import 'dart:async';
import 'package:qintar/screens/add_screen.dart';
import 'package:qintar/widgets/new_search_bar.dart';
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
//
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/geolocator_screen.dart';
import 'package:qintar/services/places_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:qintar/models/place.dart';
import 'package:qintar/models/prayer.dart';
import 'dart:collection';
import 'package:rxdart/rxdart.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

final _firestore = Firestore.instance;
List<Prayer> prayers = [];
Set<Marker> _markers = HashSet<Marker>();
GoogleMapController _controller;

class MapScreen extends StatefulWidget {
  static String id = 'map_screen';

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  Location _locationTracker = Location();
  Stream _locationSubscription;
  Circle circle;
  static bool isSearching = false;
  static AnimationController iconController;

  void updateMarker(LocationData newLocalData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      circle = Circle(
          circleId: CircleId("yourloco"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.green,
          center: latLng,
          fillColor: Colors.greenAccent);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getCurrentLocation() async {
    var location = await _locationTracker.getLocation();

    updateMarker(location);

    _locationSubscription =
        _locationTracker.onLocationChanged.listen((newLocalData) {
      if (_controller != null) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: 15.00)));
        updateMarker(newLocalData);
      }
    }) as Stream;
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      //_locationSubscription.dr();
    }

    super.dispose();
  }

  Widget build(BuildContext context) {
    // _markers.add(Marker(position: LatLng(30.0288, 31.508639)));
    final currentPosition = Provider.of<Position>(context);
    var placesProvider = Provider.of<Future<List<Place>>>(context);
    return FutureProvider(
        create: (context) => placesProvider,
        child: Scaffold(
          body: (currentPosition != null)
              ? Container(
                  child: (SafeArea(
                      child: Container(
                  height: MediaQuery.of(context).size.height - 25,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                          child: Scaffold(
                        body: Column(
                          children: <Widget>[
                            Expanded(
                              child:
                                  Stack(alignment: Alignment.center, children: <
                                      Widget>[
                                Container(
                                  //  padding:
//                EdgeInsets.only(
//                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child: StreamBuilder<QuerySnapshot>(
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                          ),
                                        );
                                      }
                                      final messages =
                                          snapshot.data.documents.reversed;
                                      for (var message in messages) {
                                        final String Id = message.documentID;
                                        final name = message.data['name'];
                                        final place = message.data['place'];
                                        final double latitude = double.parse(
                                            message.data['latitude']);
                                        final double longitude = double.parse(
                                            message.data['longitude']);
                                        final prayer = Prayer(
                                          Id: Id,
                                          place: place,
                                          name: name,
                                          latitude: latitude,
                                          longitude: longitude,
                                        );
                                        //Text('$name from $place');
                                        prayers.add(prayer);
                                        latitude != null && longitude != null
                                            ? _markers.add(
                                                Marker(
                                                  markerId: MarkerId(Id),
                                                  position: LatLng(
                                                      latitude, longitude),
                                                ),
                                              )
                                            : null;
                                      }
                                      return GoogleMap(
                                        markers: _markers,
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                            zoom: 15,
                                            target: LatLng(
                                                currentPosition.latitude,
                                                currentPosition.longitude)),
                                        compassEnabled: false,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: true,
                                        onMapCreated:
                                            // _firestore.collection('upcomingprayers').snapshots().listen();
                                            (GoogleMapController controller) {
                                          getCurrentLocation();
                                          setState(() {
                                            _controller = controller;
                                          });
                                        },
                                        zoomGesturesEnabled: true,
                                        mapToolbarEnabled: false,
                                        zoomControlsEnabled: false,
                                        circles: Set.of(
                                            (circle != null) ? [circle] : []),
                                      );
                                    },
                                    stream: _firestore
                                        .collection('upcomingprayers')
                                        .snapshots(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 10,
                                  child: FloatingActionButton(
                                    child: Icon(Icons.add_location),
                                    splashColor: Colors.yellow,
                                    elevation: 15,
                                    onPressed: () {
                                      setState(() {
                                        _markers.add(Marker(
                                            markerId: (MarkerId('Yo')),
                                            position:
                                                LatLng(30.0288, 31.508639)));
                                      });
                                      getCurrentLocation();
                                    },
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  right: 10,
                                  child: FloatingActionButton(
                                    child: Icon(Icons.refresh),
                                    splashColor: Colors.yellow,
                                    elevation: 15,
                                    onPressed: () {
                                      setState(() {});
                                      _markers = _markers;
                                    },
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )),
                      Positioned(
                          child: Visibility(
                        visible: isSearching,
                        child: ListScreen(),
                        // replacement: buildMapScreen(context, currentPosition),
                      )),
                      Positioned(
                        top: MediaQuery.of(context).viewInsets.top + 10,
                        child: GestureDetector(
                          child: Container(child: Searchbar()),
                          onTap: () {
                            setState(() {
                              isSearching = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ))))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
