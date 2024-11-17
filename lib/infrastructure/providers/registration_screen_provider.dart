import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'RegistrationScreen'
// and notify about changes in it attributes

class RegistrationScreenProvider extends ChangeNotifier {
  Ref ref;
  RegistrationScreenProvider(this.ref);

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
    activeStep++;
    notifyListeners();
  }

  /// set active step down on formulary
  void setActiveStepDown() {
    activeStep--;
    notifyListeners();
  }
}
