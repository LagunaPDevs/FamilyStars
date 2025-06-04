import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';

import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class GoogleSSOUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GoogleSSOUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> googleSignIn() async {
    final result = await authRepository.googleSSO();
    if (result.userCredential != null && result.userCredential?.user != null) {
      final String? id = await authRepository.getCurrentUserUID();
      final UserModel user = UserModel(
          id: id,
          name: result.userEmail,
          email: result.userEmail,
          familiar: 'Otro');
      final userUpdated = await userRepository.updateCurrentUser(user);
      if (userUpdated) {
        final userId = result.userCredential?.user?.uid;
        if (userId != null) await SharedPreferenceService().saveUser(userId);
      }
      return userUpdated;
    }
    return false;
  }
}
