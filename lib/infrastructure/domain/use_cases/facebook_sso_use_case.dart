import 'package:familystars_2/infrastructure/domain/model/facebook_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class FacebookSsoUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  FacebookSsoUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> facebookSignIn() async {
    final result = await _handleFacebookSSO();
    if (result.userCredential != null && result.userData != null) {
      final String? id = await _handleGetCurrentUserUID();
      if (id == null) return false;

      final Map<String, dynamic>? userData = result.userData;
      final UserModel user = UserModel(
          id: id,
          name: userData?["name"] ?? "",
          email: userData?["email"] ?? "",
          familiar: "Otro");
      final isUpdatedUser = await _handleUpdateUser(user, result);
      return isUpdatedUser;
    }
    return false;
  }

  Future<FacebookSsoResult> _handleFacebookSSO() async {
    final result = await authRepository.facebookSSO();
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return FacebookSsoResult.fromNoData();
    }
  }

  Future<String?> _handleGetCurrentUserUID() async {
    final result = await authRepository.getCurrentUserUID();
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return null;
    }
  }

  Future<bool> _handleUpdateUser(
      UserModel user, FacebookSsoResult facebookSSOResult) async {
    final result = await userRepository.updateCurrentUser(user);
    switch (result) {
      case Ok():
        {
          if (result.result) {
            final userId = facebookSSOResult.userCredential?.user?.uid;
            if (userId != null) {
              await SharedPreferenceService().saveUser(userId);
              return true;
            }
          }
          return false;
        }
      case Error():
        return false;
    }
  }
}
