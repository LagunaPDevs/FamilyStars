import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'LogInScreen'
// and notify about changes in it attributes

class LogInScreenProvider extends ChangeNotifier{

  ProviderReference ref;

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
  void setPasswordVisibility(){
    _isVisiblePassword = !_isVisiblePassword;
    notifyListeners();
  }

}