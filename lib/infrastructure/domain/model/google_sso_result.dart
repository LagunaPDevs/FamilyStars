import 'package:firebase_auth/firebase_auth.dart';

class GoogleSsoResult {
  final UserCredential? userCredential;
  final String? userName;
  final String? userEmail;

  GoogleSsoResult(
      {required this.userCredential,
      required this.userName,
      required this.userEmail});

  factory GoogleSsoResult.fromNoData() =>
      GoogleSsoResult(userCredential: null, userName: null, userEmail: null);
}
