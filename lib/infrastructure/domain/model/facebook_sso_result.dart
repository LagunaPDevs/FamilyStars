import 'package:firebase_auth/firebase_auth.dart';

class FacebookSsoResult {
  final UserCredential? userCredential;
  final Map<String, dynamic>? userData;

  FacebookSsoResult({required this.userCredential, required this.userData});

  factory FacebookSsoResult.fromNoData() =>
      FacebookSsoResult(userCredential: null, userData: null);
}
