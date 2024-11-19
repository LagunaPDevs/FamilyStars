import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
