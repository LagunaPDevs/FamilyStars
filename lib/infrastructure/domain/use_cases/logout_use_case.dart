import 'package:familystars_2/infrastructure/constants/storage_constants.dart';
import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase({required this.authRepository});

  Future<bool> logout() async {
    final result = await authRepository.logout();
    switch (result) {
      case Ok():
        await SharedPreferenceService().removeValue(StorageConstants.user);
        return true;
      case Error():
        return false;
    }
  }
}
