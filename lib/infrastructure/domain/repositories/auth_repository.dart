import 'package:familystars_2/infrastructure/domain/model/facebook_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/model/google_sso_result.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Result<String?>> getCurrentUserUID();
  Future<Result<User?>> loginWithEmail(
      {required String email, required String password});
  Future<Result<void>> logout();
  Future<Result<bool>> resetEmailPassword(String email);
  Future<Result<User?>> signUpWithEmail(
      {required String email, required String password});
  Future<Result<GoogleSsoResult>> googleSSO();
  Future<Result<FacebookSsoResult>> facebookSSO();
}

