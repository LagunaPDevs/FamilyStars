import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

// This class represents a provider that catch events in 'CreateUserScreen'
// and notify about changes in it attributes

class CreateUserScreenProvider with ChangeNotifier {
  /// get the reference for use other providers
  Ref ref;

  CreateUserScreenProvider(this.ref);

  /// child name user controller
  TextEditingController userNameController = TextEditingController();

  /// child name focus node
  FocusNode userNameFocusNode = FocusNode();

  /// text for familiar
  String familiarText = AppConstants.ninia;

  /// date for initial date
  DateTime dateTime = DateTime.utc(2010, 1, 1);

  /// text for date of birth
  String dobText = '';

  void setFamiliar(String familiar){
    familiarText = familiar;
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
    familiarText = AppConstants.ninia;
    userNameController.clear();
    notifyListeners();
  }

  Future<bool> createNewUser() async {
    final UserModel user = UserModel(name: userNameController.text, familiar: familiarText, dob: dobText);
    final createNewChildUserRef = ref.watch(createNewChildUserUseCase);
    final result = await createNewChildUserRef.createNewChildUser(user);
    return result;
  }

  String validateForm(bool formValidate){
    if(formValidate){
      bool nameIsNotEmpty = userNameController.text.isNotEmpty;
      bool familiarIsNotEmpty = familiarText.isNotEmpty;
      bool dobIsNotEmpty = dobText.isNotEmpty;
      return nameIsNotEmpty && familiarIsNotEmpty && dobIsNotEmpty ? '' : 'Some required fields are empty';
    }
    return 'Some required fields are empty';
  }
}
