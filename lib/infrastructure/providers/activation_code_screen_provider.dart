import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// This class represents a provider that catch events in 'ActivationCodeScreen'
// and notify about changes in it attributes

class ActivationCodeScreenProvider with ChangeNotifier {
  /// get the reference for use other providers
  Ref ref;
  ActivationCodeScreenProvider(this.ref);

  /// pin input controller for otp
  TextEditingController pinPutController = TextEditingController();

  /// otp textfield focus node
  FocusNode pinPutFocusNode = FocusNode();

  /// get verification code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  /// change the verification code
  void setVerificationCode(String value) {
    _verificationCode = value;
    notifyListeners();
  }
}
