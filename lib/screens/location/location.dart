import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController _mapController;
  late LatLng _currentPosition;
  late final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: _currentPosition,
        builder: (ctx) => Container(
          child: const Icon(Icons.location_on),
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _currentPosition,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: _markers)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveLocation(),
        tooltip: 'Save Location',
        child: const Icon(Icons.save),
      ),
    );
  }

  void _saveLocation() async {
    CollectionReference locations =
        FirebaseFirestore.instance.collection('user');
    locations.add({
      'latitude': _currentPosition.latitude,
      'longitude': _currentPosition.longitude,
    });
  }
}
