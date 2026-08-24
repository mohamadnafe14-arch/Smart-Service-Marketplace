import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/secrets/firebase_secrets.dart';

@lazySingleton
class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  Future<String> signIn() async {
    await _googleSignIn.initialize(
      clientId: clientId,
      serverClientId: serverId,
    );
    final googleUser = await _googleSignIn.authenticate();
    final GoogleSignInClientAuthorization? authorization = await googleUser
        .authorizationClient
        .authorizationForScopes(['email', 'profile']);
    return authorization!.accessToken;
  }
}
