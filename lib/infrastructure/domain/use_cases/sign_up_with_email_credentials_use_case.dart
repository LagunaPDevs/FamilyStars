import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class SignUpWithEmailCredentialsUseCase {
  final AuthRepository authRepository;

  SignUpWithEmailCredentialsUseCase({required this.authRepository});

  Future<bool> signUpWithEmailCredentials(
      {required String email, required String password}) async {
    final user =
        await authRepository.signUpWithEmail(email: email, password: password);
    if (user != null) {
      await SharedPreferenceService().saveUser(user.uid);
      return true;
    }
    return false;
  }
}
