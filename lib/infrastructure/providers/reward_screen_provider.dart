import 'package:familystars_2/infrastructure/models/reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

// This class represents a provider that catch events in 'RewardScreen'
// and notify about changes in it attributes

class RewardScreenProvider with ChangeNotifier {
  Ref ref;
  RewardScreenProvider(this.ref);

  var rewardController;

  String userId = '';
  String get getUserId => userId;
  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  String childStars = '';

  String get getChildStars => childStars;

  void setChildStars(String stars) {
    childStars = stars;
    notifyListeners();
  }

  UserModel? user;
  void setUser(UserModel? userModel) {
    user = userModel;
    notifyListeners();
  }

  Future<UserModel?> getUser(String childId) async {
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getUserById(childId);
    switch (result) {
      case Ok():
        setUser(result.result);
        return result.result;
      case Error():
        return null;
    }
  }

  Future<bool> claimReward({required int rewardPoints}) async {
    final claimRewardUseCaseRef = ref.watch(claimRewardUseCase);
    if (user?.id == null) return false;
    final result = await claimRewardUseCaseRef.claimReward(
        user: user, rewardPoints: rewardPoints);
    return result;
  }

  Stream<List<Reward>>? buildRewardListByCategory(String category) {
    final rewardRepoRef = ref.watch(rewardRepository);
    final result = rewardRepoRef.getRewardsFromCategory(category)?.map(
        (snapshot) =>
            snapshot.docs.map((doc) => Reward.fromJson(doc.data())).toList());
    return result;
  }

  bool onRewardClick(int rewardStars) {
    final stars = int.parse(user?.stars ?? '0');
    if (stars >= rewardStars) {
      return true;
    } else {
      return false;
    }
  }
}
