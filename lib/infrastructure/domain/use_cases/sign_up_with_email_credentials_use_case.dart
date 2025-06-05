import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpWithEmailCredentialsUseCase {
  final AuthRepository authRepository;

  SignUpWithEmailCredentialsUseCase({required this.authRepository});

  Future<bool> signUpWithEmailCredentials(
      {required String email, required String password}) async {
    final user = await _handleSignUpWithEmail(email, password);
    if (user != null) {
      await SharedPreferenceService().saveUser(user.uid);
      return true;
    }
    return false;
  }

  Future<User?> _handleSignUpWithEmail(String email, String password) async {
    final result = await authRepository.signUpWithEmail(email: email, password: password);
    switch(result){
      case Ok():
      return result.result;
      case Error():
      return null;
    }
  }
}
