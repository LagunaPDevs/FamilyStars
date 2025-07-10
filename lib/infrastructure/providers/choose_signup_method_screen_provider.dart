import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

class ChooseSignUpMethodScreenProvider with ChangeNotifier {
  Ref ref;

  ChooseSignUpMethodScreenProvider(this.ref);

  void onEmailSignUpClick(BuildContext context) => Navigator.pushNamed(context, RoutesConstants.registrationScreen); 

  Future<void> loginWithGoogle(BuildContext context) async {
    final googleSSOUseCaseRef = ref.watch(googleSSOUseCase);
    final result = await googleSSOUseCaseRef.googleSignIn();
    if (result && context.mounted) {
      Navigator.popAndPushNamed(context, RoutesConstants.parentMainScreen);
    }
    // do something with the error
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    final facebookSSOUseCaseRef = ref.watch(facebookSSOUseCase);
    final result = await facebookSSOUseCaseRef.facebookSignIn();
    if (result && context.mounted) {
      Navigator.popAndPushNamed(context, RoutesConstants.parentMainScreen);
    }
    // do something with the error
  }
}
