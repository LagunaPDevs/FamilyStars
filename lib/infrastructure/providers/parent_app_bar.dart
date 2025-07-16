import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/models/user.dart';

class ParentAppBarProvider with ChangeNotifier {
  Ref ref;

  ParentAppBarProvider(this.ref);

  bool isLoading = true;
  UserModel? user;

  void setIsLoading(bool loading){
    isLoading = loading;
    notifyListeners();
  } 

  void setUser(UserModel? userModel) {
    user = userModel;
    notifyListeners();
  }

  Future<UserModel?> getParentUser() async {
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getCurrentAuthenticatedUser();
    switch (result) {
      case Ok():
        setUser(result.result);
        return result.result;
      case Error():
        return null;
    }
  }
}
