import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

// This class represents a provider that catch events in 'LogInScreen'
// and notify about changes in it attributes

class LogInScreenProvider extends ChangeNotifier {
  Ref ref;

  LogInScreenProvider(this.ref);

  /// email controller for textfield
  TextEditingController emailController = TextEditingController();

  /// password controller for textfield
  TextEditingController passwordController = TextEditingController();

  /// email focus node for textfield
  FocusNode emailFocus = FocusNode();

  ///password focus node for textfield
  FocusNode passwordFocus = FocusNode();

  /// visible password
  bool _isVisiblePassword = false;

  bool get isVisiblePassword => _isVisiblePassword;

  /// set password visibility and notify UI
  void setPasswordVisibility() {
    _isVisiblePassword = !_isVisiblePassword;
    notifyListeners();
  }

  Future<void> loginWithEmailCredentials(BuildContext context) async {
    final loginWithEmailUseCaseRef = ref.watch(loginWithEmailCrendentialsUseCase);
    final result = await loginWithEmailUseCaseRef.loginWithEmailCredentials(email: emailController.text, password: passwordController.text);
    if(result){
      Navigator.popAndPushNamed(context, RoutesConstants.mainScreen);
    }
    // do something with the error
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    final googleSSOUseCaseRef = ref.watch(googleSSOUseCase);
    final result = await googleSSOUseCaseRef.googleSignIn();
    if(result){
      Navigator.popAndPushNamed(context, RoutesConstants.mainScreen);
    }
    // do something with the error
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    final facebookSSOUseCaseRef = ref.watch(facebookSSOUseCase);
    final result = await facebookSSOUseCaseRef.facebookSignIn();
    if(result){
      Navigator.popAndPushNamed(context, RoutesConstants.mainScreen);
    }
    // do something with the error
    
  }
}
