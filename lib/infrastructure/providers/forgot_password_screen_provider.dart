import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'ForgotPasswordScreen'
// and notify about changes in it attributes

class ForgotPasswordScreenProvider extends ChangeNotifier{

  ProviderReference ref;

  ForgotPasswordScreenProvider(this.ref);

  /// email controller for textfield
  TextEditingController emailController = TextEditingController();

  /// email focus node for textfield
  FocusNode emailFocus = FocusNode();

}