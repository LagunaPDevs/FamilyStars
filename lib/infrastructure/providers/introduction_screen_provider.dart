import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

class IntroductionScreenProvider with ChangeNotifier {
  Ref ref;

  IntroductionScreenProvider(this.ref);

  String? userId;

  Future<String?> getUserInStorage() async {
    String? userId = SharedPreferenceService().getUser();
    return userId;
  }

  void onStartClick(BuildContext context) =>
      Navigator.of(context).popAndPushNamed(RoutesConstants.loginScreen);
}
