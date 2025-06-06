import 'package:familystars_2/infrastructure/data_sources/auth_data_source.dart';
import 'package:familystars_2/infrastructure/domain/model/facebook_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/model/google_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';

import 'package:familystars_2/infrastructure/errors/exceptions.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Result<String?>> getCurrentUserUID() async {
    try {
      final result = await dataSource.getCurrentUserUID();
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<User?>> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final result =
          await dataSource.loginWithEmail(email: email, password: password);
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      final result = await dataSource.logout();
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> resetEmailPassword(String email) async {
    try {
      final result = await dataSource.resetEmailPassword(email);
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<User?>> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      final result =
          await dataSource.signUpWithEmail(email: email, password: password);
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<FacebookSsoResult>> facebookSSO() async {
    try {
      final result = await dataSource.facebookSSO();
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<GoogleSsoResult>> googleSSO() async {
    try {
      final result = await dataSource.googleSSO();
      return Result.ok(result);
    } on AuthException catch (e) {
      return Result.error(e);
    }
  }
}
