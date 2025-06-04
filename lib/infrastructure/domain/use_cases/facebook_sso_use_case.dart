import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';

import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class FacebookSsoUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  FacebookSsoUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> facebookSignIn() async {
    final result = await authRepository.facebookSSO();
    if (result.userCredential != null && result.userData != null) {
      final String? id = await authRepository.getCurrentUserUID();
      final Map<String, dynamic>? userData = result.userData;
      final UserModel user = UserModel(
          id: id,
          name: userData?["name"] ?? "",
          email: userData?["email"] ?? "",
          familiar: "Otro");
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
