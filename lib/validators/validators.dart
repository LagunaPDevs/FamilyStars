import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/regex_constants.dart';
import 'package:flutter/cupertino.dart';

class Validators {
  // validate email enter by user
  static String? validateEmail(BuildContext context, String value) {
    RegExp regExpInValidChar = RegExp(RegxConstants.RegexForInValidChar);
    RegExp regExpValidEmail = RegExp(RegxConstants.RegexForValidEmail);
    if (value.trim().isEmpty) {
      return AppConstants.emailAddressEmptyText;
    } else if (!value.contains("@")) {
      return AppConstants.emailAddressSingleAtTheRate;
    } else if (value.split("@").length > 2) {
      return AppConstants.emailAddressMultipleAtTheRate;
    } else if (!value.split("@").last.contains(".")) {
      return AppConstants.emailAddressSingleDot;
    } else if (value.split("@").last.split(".")[0].isEmpty) {
      return AppConstants.emailAddressValidDomain;
    } else if (value.split("@").last.split(".")[1].isEmpty) {
      return AppConstants.emailAddressValidDomain;
    } else if (regExpInValidChar.hasMatch(value)) {
      return AppConstants.emailAddressInvalidCharacterInEmail;
    } else if (regExpValidEmail.hasMatch(value)) {
      return AppConstants.emailAddressInValidEmail;
    } else {
      return null;
    }
  }

  // validate password entered by user
  static String? validatePassword(BuildContext context, String value) {
    if (value.trim().isEmpty) {
      return AppConstants.passwordEmptyText;
    } else if (value.trim().length < 6) {
      return AppConstants.passwordValidText;
    } else {
      return null;
    }
  }

  // validate full name entered by parent user, it will be necessary last name
  static String? validateFullName(
    BuildContext context,
    String value,
  ) {
    if (value.trim().isEmpty) {
      return AppConstants.fullNameEmptyText;
    } else if (!value.contains(' ')) {
      return AppConstants.fullNameEnterLastNameText;
    } else {
      return null;
    }
  }

  //validate name for a child user, last name will not be necessary
  static String? validateName(
    BuildContext context,
    String value,
  ) {
    if (value.trim().isEmpty) {
      return AppConstants.fullNameEmptyText;
    } else {
      return null;
    }
  }

  static String? emailExists(BuildContext context, String value, bool exists) {
    RegExp regExpInValidChar = RegExp(RegxConstants.RegexForInValidChar);
    RegExp regExpValidEmail = RegExp(RegxConstants.RegexForValidEmail);
    if (value.trim().isEmpty) {
      return AppConstants.emailAddressEmptyText;
    } else if (!value.contains("@")) {
      return AppConstants.emailAddressSingleAtTheRate;
    } else if (value.split("@").length > 2) {
      return AppConstants.emailAddressMultipleAtTheRate;
    } else if (!value.split("@").last.contains(".")) {
      return AppConstants.emailAddressSingleDot;
    } else if (value.split("@").last.split(".")[0].isEmpty) {
      return AppConstants.emailAddressValidDomain;
    } else if (value.split("@").last.split(".")[1].isEmpty) {
      return AppConstants.emailAddressValidDomain;
    } else if (regExpInValidChar.hasMatch(value)) {
      return AppConstants.emailAddressInvalidCharacterInEmail;
    } else if (regExpValidEmail.hasMatch(value)) {
      return AppConstants.emailAddressInValidEmail;
    } else if (exists) {
      return AppConstants.emailExists;
    } else {
      return null;
    }
  }
}
