import 'dart:async';
import 'package:qintar/screens/list_screen.dart';
import 'package:qintar/screens/profile/profile.dart';
import 'package:qintar/screens/onboarding/components/launch_screen.dart';
import 'package:qintar/screens/onboarding/intro_screen.dart';
import 'add_event_screen.dart';
import 'package:qintar/widgets/new_search_bar.dart';
import 'package:qintar/widgets/list_card.dart';
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
import 'package:qintar/models/time_slot.dart';

final _firestore = Firestore.instance;
List<Prayer> prayers = [];
List<ListCard> listCards = [];
Set<Marker> _markers = HashSet<Marker>();
GoogleMapController _controller;

class MapScreen extends StatefulWidget {
  static String id = 'map_screen';

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  TabController _tabController;
  Location _locationTracker = Location();
  Stream _locationSubscription;
  Circle circle;
  static bool isSearching = false;
  static AnimationController iconController;
  static const tabs = <Tab>[
    Tab(
//      icon: ,
      child: Icon(
        Icons.person,
        color: Color(0xFF50B184),
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.map,
        color: Color(0xFF50B184),
        size: 30,
      ),
    ),
    Tab(
      child: Icon(
        Icons.view_list,
        color: Color(0xFF50B184),
        size: 30,
      ),
    ),
    Tab(
//      icon: ,
      child: Icon(
        Icons.add_location,
        color: Color(0xFF50B184),
        size: 30,
      ),
    ),
  ];

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
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
    // TODO: implement initState
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
                zoom: 10.00)));
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
    return Scaffold(
      appBar: null,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ProfileScreen(),
          buildStreamBuilder(currentPosition),
          ListScreen(listCards),
          AddEventScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder(Position currentPosition) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('upcomingprayers').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        List<Timestamp> timeSlots;
        final fields = snapshot.data.documents;
        listCards.clear();
        print("cleared listcards");
        for (var field in fields) {
          final List<Timestamp> timeSlots = List.from(field.data['timeSlots']);
          final String Id = field.documentID;
          final city = field.data['city'];
          print(city);
          final place = field.data['place'];
          final List<bool> amenities = List.from(field.data['amenities']);
          double latitude;
          double longitude;
          try {
            latitude = double.parse(field.data['latitude']);
            longitude = double.parse(field.data['longitude']);
          } catch (e) {
            latitude = (field.data['latitude']);
            longitude = (field.data['longitude']);
          }
          final prayer = Prayer(
            Id: Id,
            place: place,
            city: city,
            latitude: latitude,
            longitude: longitude,
          );
          final listCard = ListCard(
            Id: Id,
            place: place,
            city: city,
            timeSlots: timeSlots,
            amenities: amenities,
          );
          //Text('$name from $place');
          prayers.add(prayer);
          listCards.add(listCard);
          latitude != null && longitude != null
              ? _markers.add(
                  Marker(
                    infoWindow: InfoWindow(title: city),
                    markerId: MarkerId(Id),
                    position: LatLng(latitude, longitude),
                  ),
                )
              : null;
        }
        return Scaffold(
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
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        //  padding:
//                EdgeInsets.only(
//                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: buildGoogleMap(currentPosition),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  GoogleMap buildGoogleMap(Position currentPosition) {
    return GoogleMap(
      markers: _markers,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
          zoom: 12,
          target: LatLng(currentPosition.latitude, currentPosition.longitude)),
      compassEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        getCurrentLocation();
        setState(() {
          _controller = controller;
        });
      },
      zoomGesturesEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      circles: Set.of((circle != null) ? [circle] : []),
    );
  }
}
