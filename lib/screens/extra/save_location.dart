import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveLocation(double latitude, double longitude) async {
    try {
      // Save the user's location in Firestore
      await _firestore.collection('locations').add({
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      print('Error saving location: $e');
    }
  }
}
