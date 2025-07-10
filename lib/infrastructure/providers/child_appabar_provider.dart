import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

// This class represents a provider that catch events in 'ChildAppBar'
// and notify about changes in it attributes

class ChildAppBarProvider extends ChangeNotifier {
  Ref ref;
  ChildAppBarProvider(this.ref);

  UserModel? user;
  String childId = '';
  String childStars = '';
  bool isLoading = true;
  String get getChildId => childId;

  void setChildId(String id) {
    childId = id;
    notifyListeners();
  }

  void setUser(UserModel? userModel){
    user = userModel;
    notifyListeners();
  }

  void setIsLoading(bool loading){
    isLoading = loading;
    notifyListeners();
  }

  String get getChildStars => childStars;

  void setChildStars(String stars) {
    childStars = stars;
    notifyListeners();
  }

  Future<UserModel?> getUserById(String userId)async{
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getUserById(userId);
    setIsLoading(false);
    switch(result){
      case Ok():
        setUser(result.result);
        return result.result;
      case Error():
        return null;
    }
  }
}
