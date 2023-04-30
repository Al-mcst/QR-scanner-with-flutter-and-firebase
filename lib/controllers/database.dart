import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('user');
      // Call the user's CollectionReference to add a new user
      await users.doc(email).set({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getUser(
      {required String email, required String password}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('user');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data['name'];
    } catch (e) {
      return 'Error fetching user';
    }
  }
}
