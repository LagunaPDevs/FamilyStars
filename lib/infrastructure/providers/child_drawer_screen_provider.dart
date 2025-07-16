import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

class ChildDrawerScreenProvider with ChangeNotifier {
  Ref ref;

  ChildDrawerScreenProvider(this.ref);

  UserModel? authenticatedUser;

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  bool isLoading = false;

  void setAuthenticatedUser(UserModel? user) {
    authenticatedUser = user;
    notifyListeners();
  }

  void setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<UserModel?> getUser(String id) async {
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getUserById(id);
    switch (result) {
      case Ok():
        return result.result;
      case Error():
        return null;
    }
  }

  Future<UserModel?> getAuthenticatedUser() async {
    final userRepoRef = ref.watch(userRepository);
    final result = await userRepoRef.getCurrentAuthenticatedUser();
    switch (result) {
      case Ok():
        setAuthenticatedUser(result.result);
        return result.result;
      case Error():
        return null;
    }
  }

  Future<bool> checkPassword() async {
    UserModel? parentUser = authenticatedUser;
    if (parentUser == null) {
      setIsLoading(true);
      parentUser = await getAuthenticatedUser();
    }
    if (isLoading) setIsLoading(false);
    return passwordMatches(parentUser?.password);
  }

  bool passwordMatches(String? password) {
    if (password == passwordController.text) return true;
    return false;
  }

  Future<void> handleOnOkClick(BuildContext context) async {
    final result = await checkPassword();
    if (result && context.mounted) {
      Navigator.popAndPushNamed(context, RoutesConstants.parentMainScreen);
    } else {
      if (context.mounted) displayAccessDeniedDialog(context);
    }
  }

  // Alert dialog warns to child user that action is not permitted
  displayAccessDeniedDialog(BuildContext context) {
    CustomAnimatedAlertDialog(
            title: AppConstants.deniedAccess,
            content: AppConstants.notPermitted,
            context: context)
        .show();
  }

  void openMainScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.childMainScreen);
}
