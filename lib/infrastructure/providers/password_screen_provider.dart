import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

// This class represents a provider that catch events in 'CalendarScreen'
// and notify about changes in it attributes

class PasswordScreenProvider with ChangeNotifier {
  Ref ref;

  PasswordScreenProvider(this.ref);

  /// pin input controller for otp
  TextEditingController passwordController = TextEditingController();

  /// otp textfield focus node
  FocusNode passwordFocusNode = FocusNode();

  Future<bool> updateUserPassword() async {
    final userRepoRef = ref.watch(userRepository);
    final user = await _currentUser();
    if (user == null) return false;
    user.password = passwordController.text;
    final result = await userRepoRef.updateCurrentUser(user);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }

  Future<UserModel?> _currentUser() async {
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getCurrentAuthenticatedUser();
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return null;
    }
  }
}
