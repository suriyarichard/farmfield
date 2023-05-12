import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertyFieldMap extends StatefulWidget {
  @override
  _PropertyFieldMapState createState() => _PropertyFieldMapState();
}

class _PropertyFieldMapState extends State<PropertyFieldMap> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Field Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Initial map coordinates
          zoom: 11.5, // Initial zoom level
        ),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
