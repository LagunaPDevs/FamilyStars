import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';

// This class represents a provider that catch events in 'ForgotPasswordScreen'
// and notify about changes in it attributes

class ForgotPasswordScreenProvider extends ChangeNotifier {
  Ref ref;

  ForgotPasswordScreenProvider(this.ref);

  /// email controller for textfield
  TextEditingController emailController = TextEditingController();

  /// email focus node for textfield
  FocusNode emailFocus = FocusNode();

  Future<bool> onResetPassordClick() async {
    final authRepoRef = ref.watch(authRepository);
    final result = await authRepoRef.resetEmailPassword(emailController.text);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return false;
    }
  }
}
