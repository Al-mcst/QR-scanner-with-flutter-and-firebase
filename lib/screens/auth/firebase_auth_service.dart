import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'auth_error.dart';
import 'user_information.dart';
import 'auth_service.dart';

class AuthenticationService implements AuthService {
  AuthenticationService({
    required auth.FirebaseAuth authService,
  }) : _firebaseAuth = authService;

  final auth.FirebaseAuth _firebaseAuth;

  UserEntity _mapFirebaseUser(auth.User? user) {
    if (user == null) {
      return UserEntity.empty();
    }

    final map = <String, dynamic>{
      'id': user.uid,
      'firstName': '',
      'lastName': '',
      'email': user.email,
      'emailVerified': user.emailVerified,
      // 'imageUrl': user.photoURL ?? '',
      //'isAnonymous': user.isAnonymous,
      //'age': 0,
      'phoneNumber': '',
      'password': '',
      //'address': '',
    };
    return UserEntity.fromJson(map);
  }

  // static Future intializeService() async {
  //   //Lets call this init method from main function before runApp function call
  //   //For web app we need to initialize it differently
  //   if (kIsWeb) {
  //     await Firebase.initializeApp(
  //         options: const FirebaseOptions(
  //             apiKey: "AIzaSyAucWpV-QfX4W9lD45aLcIGIpwIZKm6bDI",
  //             authDomain: "watcher-5cf14.firebaseapp.com",
  //             projectId: "watcher-5cf14",
  //             storageBucket: "watcher-5cf14.appspot.com",
  //             messagingSenderId: "466249108854",
  //             appId: "1:466249108854:web:d9518b83dfd1d5311cfe57",
  //             measurementId: "G-KFCNQFP9T9"));
  //   } else {
  //     await Firebase.initializeApp();
  //   }
  // }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(userCredential.user!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<UserEntity> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(_firebaseAuth.currentUser!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  AuthError _determineError(auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return AuthError.invalidEmail;
      case 'user-disabled':
        return AuthError.userDisabled;
      case 'user-not-found':
        return AuthError.userNotFound;
      case 'invalid-phone-number':
        return AuthError.invalidPhoneNumber;
      case 'wrong-password':
        return AuthError.wrongPassword;
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return AuthError.emailAlreadyInUse;
      case 'invalid-credential':
        return AuthError.invalidCredential;
      case 'operation-not-allowed':
        return AuthError.operationNotAllowed;
      case 'weak-password':
        return AuthError.weakPassword;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return AuthError.error;
    }
  }

  static void intializeService() {}
}
