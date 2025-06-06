import 'package:familystars_2/infrastructure/domain/model/google_sso_result.dart';
import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class GoogleSSOUseCase {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GoogleSSOUseCase(
      {required this.authRepository, required this.userRepository});

  Future<bool> googleSignIn() async {
    final result = await _handleGoogleSSO();
    if (result.userCredential != null && result.userCredential?.user != null) {
      final String? id = await _handleGetCurrentUserUID();
      final UserModel user = UserModel(
          id: id,
          name: result.userEmail,
          email: result.userEmail,
          familiar: 'Otro');
      final isUpdatedUser = await _handleUpdateUser(user, result);
      return isUpdatedUser;
    }
    return false;
  }

  Future<GoogleSsoResult> _handleGoogleSSO() async {
    final result = await authRepository.googleSSO();
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return GoogleSsoResult.fromNoData();
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
      UserModel user, GoogleSsoResult googleSSOResult) async {
    final result = await userRepository.updateCurrentUser(user);
    switch (result) {
      case Ok():
        {
          if (result.result) {
            final userId = googleSSOResult.userCredential?.user?.uid;
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
