import 'package:familystars_2/infrastructure/domain/model/facebook_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/model/google_sso_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:familystars_2/infrastructure/constants/error_constants.dart';
import 'package:familystars_2/infrastructure/errors/exceptions.dart';

abstract class AuthDataSource {
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

class AuthDataSourceImpl extends AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseCrashlytics firebaseCrashlytics;

  AuthDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseCrashlytics});

  @override
  Future<String?> getCurrentUserUID() async {
    try {
      return firebaseAuth.currentUser?.uid.toString();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<User?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw AuthException(message: "Error logging in with email-password");
      });
      return userCredential.user;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<bool> resetEmailPassword(String email) async {
    try {
      final result = await firebaseAuth
          .sendPasswordResetEmail(email: email)
          .then((value) => true)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw AuthException(message: "Error sending reset email");
      });
      return result;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<User?> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw AuthException(
            message: "Error registering user with email-password credentials");
      });
      return userCredential.user;
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<FacebookSsoResult> facebookSSO() async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken?.tokenString ?? "");
      UserCredential userCredential = await firebaseAuth
          .signInWithCredential(credential)
          .onError((e, stack) {
        firebaseCrashlytics.recordError(e, stack);
        throw AuthException(
            message: "Error registering with facebook credentials");
      });
      return FacebookSsoResult(
          userCredential: userCredential, userData: userData);
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }

  @override
  Future<GoogleSsoResult> googleSSO() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication authentication =
            await googleAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken);

        final UserCredential userCredential = await firebaseAuth
            .signInWithCredential(credential)
            .onError((e, stack) {
          firebaseCrashlytics.recordError(e, stack);
          throw AuthException(
              message: "Error registering with google credentials");
        });
        return GoogleSsoResult(
            userCredential: userCredential,
            userName: googleAccount.displayName,
            userEmail: googleAccount.email);
      }
      return GoogleSsoResult.fromNoData();
    } catch (e, stack) {
      firebaseCrashlytics.recordError(e, stack);
      throw AuthException(message: ErrorConstants.unhandled);
    }
  }
}
