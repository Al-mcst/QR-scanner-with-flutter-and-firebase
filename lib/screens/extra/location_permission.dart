// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:latlong2/latlong.dart';

// Position position = await Geolocator.getCurrentPosition(
//   desiredAccuracy: LocationAccuracy.high,
// );

// Firestore.instance.collection('user').document(userId).setData({
//   'latitude': position.latitude,
//   'longitude': position.longitude,
// });

// MapController mapController = MapController();

// flutterMap(
//   MapController MapController,
//   options: MapOptions(
//     center: LatLng(position.latitude, position.longitude),
//     zoom: 13.0,
//   ),
//   layers: [
//     TileLayerOptions(
//       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//       subdomains: ['a', 'b', 'c'],
//     ),
//     MarkerLayerOptions(
//       markers: [
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: LatLng(position.latitude, position.longitude),
//           builder: (context) => const Icon(
//             Icons.location_on,
//             size: 50.0,
//             color: Colors.red,
//           ),
//         ),
//       ],
//     ),
//   ],
// );





// import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

// class LocationService {
//   final location = Location();

//   Future<LocationData> getCurrentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionStatus;

//     // Check if location services are enabled
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return null;
//       }
//     }

//     // Check if the app has permission to access location
//     permissionStatus = await location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await location.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         return null;
//       }
//     }

//     // Get the current location
//     return await location.getLocation();
//   }

//   Future<Position> getCurrentPosition() async {
//     // Get the current position using the geolocator package
//     return await Geolocator.getCurrentPosition();
//   }
// }



