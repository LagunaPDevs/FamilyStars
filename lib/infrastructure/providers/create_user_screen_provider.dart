import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';

// This class represents a provider that catch events in 'CreateUserScreen'
// and notify about changes in it attributes

class CreateUserScreenProvider with ChangeNotifier {
  /// get the reference for use other providers
  ProviderReference ref;

  CreateUserScreenProvider(this.ref);

  /// pin input controller for otp
  TextEditingController userNameController = TextEditingController();

  /// otp textfield focus node
  FocusNode userNameFocusNode = FocusNode();

  /// text for familiar
  String familiarText = 'Niña';

  /// is girl
  bool isNinia = true;

  /// is boy
  bool isNinio = false;

  /// is other
  bool isOther = false;

  /// date for initial date
  DateTime dateTime = DateTime.utc(2010, 1, 1);

  /// text for date of birth
  String dobText = '';

  /// set familiar to ninia
  void setNinia() {
    isNinia = true;
    isNinio = false;
    isOther = false;
    familiarText = AppConstants.ninia;
    notifyListeners();
  }

  /// set familiar to ninio
  void setNinio() {
    isNinia = false;
    isNinio = true;
    isOther = false;
    familiarText = AppConstants.ninio;
    notifyListeners();
  }

  /// set familiar to other
  void setOther() {
    isNinia = false;
    isNinio = false;
    isOther = true;
    familiarText = AppConstants.other;
    notifyListeners();
  }

  /// set child date of birth
  void setDob() {
    dobText = '${dateTime.day}, ${dateTime.month}, ${dateTime.year}';
    notifyListeners();
  }

  /// clean all the fields
  void cleanFields() {
    dateTime = DateTime.utc(2010, 1, 1);
    setNinia();
    userNameController.clear();
    notifyListeners();
  }
}
