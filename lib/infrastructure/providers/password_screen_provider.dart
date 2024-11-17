import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a provider that catch events in 'CalendarScreen'
// and notify about changes in it attributes

class PasswordScreenProvider extends ChangeNotifier {
  Ref ref;

  PasswordScreenProvider(this.ref);

  /// pin input controller for otp
  TextEditingController passwordController = TextEditingController();

  /// otp textfield focus node
  FocusNode passwordFocusNode = FocusNode();
}
