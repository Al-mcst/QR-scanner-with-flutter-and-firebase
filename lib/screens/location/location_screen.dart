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
