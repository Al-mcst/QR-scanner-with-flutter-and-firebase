import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<LatLng?> getUserLocation() async {
  final snapshot =
      await FirebaseFirestore.instance.collection('locations').get();
  if (snapshot.docs.isNotEmpty) {
    final doc = snapshot.docs.first;
    final latitude = doc['latitude'];
    final longitude = doc['longitude'];
    return LatLng(latitude, longitude);
  }
  return null;
}

class MyMapScreen extends StatefulWidget {
  @override
  _MyMapScreenState createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  LatLng _location;

  @override
  void initState() {
    super.initState();
    getUserLocation().then((location) {
      setState(() {
        _location = location;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: FlutterMap(
        options: MapOptions(
          center: _location ?? LatLng(0, 0),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: _location != null
                ? [
                    Marker(
                      point: _location,
                      builder: (context) => Icon(Icons.location_pin),
                    ),
                  ]
                : [],
          ),
        ],
      ),
    );
  }
}
