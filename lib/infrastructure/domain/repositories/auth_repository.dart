import 'package:familystars_2/infrastructure/data_sources/auth_data_source.dart';
import 'package:familystars_2/infrastructure/domain/model/facebook_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/model/google_sso_result.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String?> getCurrentUserUID();
  Future<User?> loginWithEmail(
      {required String email, required String password});
  Future<void> logout();
  Future<bool> resetEmailPassword(String email);
  Future<User?> signUpWithEmail(
      {required String email, required String password});
  Future<GoogleSsoResult> googleSSO();
  Future<FacebookSsoResult> facebookSSO();
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<String?> getCurrentUserUID() async {
    try {
      final result = await dataSource.getCurrentUserUID();
      return result;
    } on AuthException catch (_) {
      return null;
    }
  }

  @override
  Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final result =
          await dataSource.loginWithEmail(email: email, password: password);
      return result;
    } on AuthException catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final result = await dataSource.logout();
      return result;
    } on AuthException catch (_) {
      return;
    }
  }

  @override
  Future<bool> resetEmailPassword(String email) async {
    try {
      final result = await dataSource.resetEmailPassword(email);
      return result;
    } on AuthException catch (_) {
      return false;
    }
  }

  @override
  Future<User?> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      final result =
          await dataSource.signUpWithEmail(email: email, password: password);
      return result;
    } on AuthException catch (_) {
      return null;
    }
  }

  @override
  Future<FacebookSsoResult> facebookSSO() async {
    try {
      final result = await dataSource.facebookSSO();
      return result;
    } on AuthException catch (_) {
      return FacebookSsoResult.fromNoData();
    }
  }

  @override
  Future<GoogleSsoResult> googleSSO() async {
    try {
      final result = await dataSource.googleSSO();
      return result;
    } on AuthException catch (_) {
      return GoogleSsoResult.fromNoData();
    }
  }
}
