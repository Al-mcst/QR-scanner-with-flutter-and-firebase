import 'user_information.dart';

abstract class AuthService {
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserEntity> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String phoneNumber,
      required String firstName,
      required String lastName});
}
