import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';

class DrawerScreenProvider with ChangeNotifier {
  Ref ref;

  DrawerScreenProvider(this.ref);

  void openMainScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.parentMainScreen);
  void openCreateUserScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.createUserScreen);
  void openChangeUserScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.changeUserScreen);
  void openAboutUsScreen(BuildContext context) =>
      Navigator.popAndPushNamed(context, RoutesConstants.aboutUsScreen);

  Future<void> logout(BuildContext context) async {
    final logoutRef = ref.watch(logoutUseCase);
    final result = await logoutRef.logout();
    if (result && context.mounted) {
      Navigator.popAndPushNamed(context, RoutesConstants.loginScreen);
    }
  }
}
