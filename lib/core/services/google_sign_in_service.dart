import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_service_market_place/core/secrets/firebase_secrets.dart';
import 'package:smart_service_market_place/features/auth/model/models/google_credintials_model.dart';

@lazySingleton
class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  Future<GoogleCredintialsModel> signIn() async {
    await _googleSignIn.initialize(
      clientId: clientId,
    );
    final googleUser = await _googleSignIn.authenticate();
    return GoogleCredintialsModel(
      id_token: googleUser.authentication.idToken!,
      email: googleUser.email,
    );
  }
}
