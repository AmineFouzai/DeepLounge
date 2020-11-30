import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  Position position;

  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    super.initState();

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((value) => setState(() {
              position = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        buildingsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 20.4746,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocalPostion,
        label: Text('My Postion'),
        icon: Icon(Icons.emoji_food_beverage),
      ),
    );
  }

  Future<void> _goToLocalPostion() async {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("localpostion"),
          position: LatLng(position.latitude, position.longitude)));
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position.latitude, position.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));
  }
}
