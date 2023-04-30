import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

//import "package:latlong/latlong.dart";
Widget build(BuildContext context) {
  return FlutterMap(
    options: MapOptions(
      center: LatLng(51.5, -0.09),
      zoom: 13.0,
    ),
    layers: [
      MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
    children: <Widget>[
      TileLayerWidget(options: TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      )),
      MarkerLayerWidget(options: MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      )),
    ],
  );
}




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


//1
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LocationScreen extends StatelessWidget {
//   const LocationScreen({super.key});
// }

// final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// QRViewController? controller;
// bool scanning = true;
// LatLng? location;

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Stack(
//       children: <Widget>[
//         FlutterMap(
//           options: MapOptions(
//             center: LatLng(0, 0),
//             zoom: 13.0,
//           ),
//           layers: [
//             TileLayerOptions(
//               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//               subdomains: ['a', 'b', 'c'],
//             ),
//             MarkerLayerOptions(
//               markers: location != null ? [Marker(point: location!)] : [],
//             ),
//           ],
//         ),
//         QRView(
//           key: qrKey,
//           onQRViewCreated: _onQRViewCreated,
//         ),
//         Positioned(
//           bottom: 16,
//           left: 16,
//           child: ElevatedButton(
//             onPressed: scanning ? null : _stopScan,
//             child: Text('Stop Scan'),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// void _onQRViewCreated(QRViewController controller) {
//   this.controller = controller;
//   controller.scannedDataStream.listen((scanData) {
//     // Stop scanning to avoid multiple scans
//     _stopScan();
//     // Get the location and update the map
//     getLocationAndMap(scanData.code);
//   });
// }

// void _stopScan() {
//   controller?.pauseCamera();
//   setState(() {
//     scanning = false;
//   });
// }


//2
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:http/http.dart' as http;
// import 'package:latlong2/latlong.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LocationPicker extends StatefulWidget {
//   @override
//   _LocationPickerState createState() => _LocationPickerState();
// }

// class _LocationPickerState extends State<LocationPicker> {
//   final TextEditingController _searchController = TextEditingController();
//   LatLng _pickedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pick a location'),
//       ),
//       body: OpenStreetMapSearchAndPick(
//         apiKey: 'YOUR_API_KEY', // Replace with your OpenStreetMap API key
//         controller: _searchController,
//         onPickedLocation: (location) {
//           setState(() {
//             _pickedLocation = location;
//           });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           saveLocation();
//         },
//         child: const Icon(Icons.save),
//       ),
//     );
//   }

// void saveLocation(LatLng location) {
//   FirebaseFirestore.instance.collection('locations').add({
//     'latitude': location.latitude,
//     'longitude': location.longitude,
//   });
// }
// }




