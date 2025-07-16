import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

class ClaimRewardUseCase {
  final UserRepository userRepository;

  ClaimRewardUseCase({required this.userRepository});

  Future<bool> claimReward(
      {required UserModel? user, required int rewardPoints}) async {
    if (user == null) return false;
    int userStars = int.parse(user.stars ?? '0');
    int difference = userStars - rewardPoints;
    user.stars = difference.toString();
    final result = await userRepository.updateCurrentUser(user);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }
}
