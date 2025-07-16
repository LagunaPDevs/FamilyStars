import 'package:familystars_2/infrastructure/errors/result.dart';

import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';


class UpdateUserStarsFromTaskUseCase {
  final UserRepository userRepository;

  UpdateUserStarsFromTaskUseCase({required this.userRepository});

  Future<bool> updateUserStars({required Task task}) async {
    final user = await _getUser(task.assigned ?? '');
    if (user == null) return false;
    final starsUpdateResult =
        await _updateStars(user: user, taskStars: task.stars ?? '');
    return starsUpdateResult;
  }

  Future<UserModel?> _getUser(String userId) async {
    final result = await userRepository.getUserById(userId);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return null;
    }
  }

  Future<bool> _updateStars(
      {required UserModel user, required taskStars}) async {
    final userStars = int.parse(user.stars ?? '0');
    final totalStars = int.parse(taskStars) + userStars;
    user.stars = totalStars.toString();
    final result = await userRepository.updateCurrentUser(user);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }
}
