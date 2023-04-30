import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final location = Location();

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if the app has permission to access location
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return null;
      }
    }

    // Get the current location
    return await location.getLocation();
  }

  Future<Position> getCurrentPosition() async {
    // Get the current position using the geolocator package
    return await Geolocator.getCurrentPosition();
  }
}
