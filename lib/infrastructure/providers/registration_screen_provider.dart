import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/errors/result.dart';
import 'package:familystars_2/infrastructure/models/user.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';

/// This class represents a provider that catch events in 'RegistrationScreen'
/// and notify about changes in it attributes

class RegistrationScreenProvider extends ChangeNotifier {
  Ref ref;
  RegistrationScreenProvider(this.ref);

  /// is loading
  bool isLoading = false;

  /// active step on formulary
  int activeStep = 0;

  /// last step on formulary
  int upperBound = 2;

  /// email controller for textfield
  TextEditingController emailController = TextEditingController();

  /// password controller for textfield
  TextEditingController passwordController = TextEditingController();

  /// full name controller for textfield
  TextEditingController fullnameController = TextEditingController();

  /// email focus node for textfield
  FocusNode emailFocus = FocusNode();

  /// password focus node for textfield
  FocusNode passwordFocus = FocusNode();

  /// full name focus node for textfield
  FocusNode fullnameFocus = FocusNode();

  /// text for familiar
  String familiarText = 'Madre';

  /// text for date of birth
  String dobText = '';

  /// visible password
  bool _isVisiblePassword = false;

  bool get isVisiblePassword => _isVisiblePassword;

  /// set password visibility and notify UI
  void setPasswordVisibility() {
    _isVisiblePassword = !_isVisiblePassword;
    notifyListeners();
  }

  /// set active step up on formulary
  void setActiveStepUp() {
    if (activeStep < upperBound) {
      activeStep++;
      notifyListeners();
    }
  }

  /// set active step down on formulary
  void setActiveStepDown() {
    if (activeStep > 0) {
      activeStep--;
      notifyListeners();
    }
  }

  void setFamiliarText(String value) {
    familiarText = value;
    notifyListeners();
  }

  void setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<dynamic> handleNext(BuildContext context) async {
    if (activeStep == 0) {
      setIsLoading(true);
      final result = await signUpWithEmail();
      setIsLoading(false);
      return result;
    }
    setActiveStepUp();
  }

  Future<bool> signUpWithEmail() async {
    final signUpWithEmailRef = ref.watch(signUpWithEmailCredentialsUseCase);
    final result = await signUpWithEmailRef.signUpWithEmailCredentials(
        email: emailController.text, password: passwordController.text);
    if (result) {
      setActiveStepUp();
    }
    return result;
  }

  Future<bool> updateUserData(BuildContext context) async {
    final userRepositoryRef = ref.watch(userRepository);
    final currentUserId = SharedPreferenceService().getUser();
    final user = UserModel(
        id: currentUserId,
        name: fullnameController.text,
        familiar: familiarText,
        email: emailController.text,
        password: passwordController.text,
        dob: dobText);
    final result = await userRepositoryRef.setCurrentUser(user);
    switch (result) {
      case Ok():
        if (context.mounted) {
          Navigator.pushNamed(context, RoutesConstants.mainScreen);
          return true;
        }
        break;
      case Error():
        return false;
    }
    return false;
  }
}
