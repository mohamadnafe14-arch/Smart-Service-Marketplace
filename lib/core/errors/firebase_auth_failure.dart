import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_service_market_place/core/errors/failure.dart';

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure({required super.message});
  factory FirebaseAuthFailure.fromfirebaseauthexception(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'email-already-in-use':
        return FirebaseAuthFailure(message: 'Email already in use');
      case 'invalid-email':
        return FirebaseAuthFailure(message: 'Invalid email');
      case 'user-not-found':
        return FirebaseAuthFailure(message: 'User not found');
      case 'wrong-password':
        return FirebaseAuthFailure(message: 'Wrong password');
      case 'user-disabled':
        return FirebaseAuthFailure(message: 'User disabled');
      case 'operation-not-allowed':
        return FirebaseAuthFailure(message: 'Operation not allowed');    
      default:
        return FirebaseAuthFailure(message: 'Something went wrong');
    }
  }
}
