import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Widget that holds a calendar where user can select it birthdate

class RegistrationDobStep extends StatefulWidget {
  const RegistrationDobStep({Key? key}) : super(key: key);

  @override
  _RegistrationDobStepState createState() => _RegistrationDobStepState();
}

class _RegistrationDobStepState extends State<RegistrationDobStep> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final registrationProviderRes = watch(registrationScreenProvider);
      DateTime dateTime = DateTime.utc(2000, 1, 1);
      return Column(
        children: [
          Text(
            AppConstants.dob,
          ),
          SizedBox(
            height: 180,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Brightness.light,
              ),
              child: CupertinoDatePicker(
                key: _formKey,
                initialDateTime: dateTime,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime) => setState(() {
                  registrationProviderRes.dobText =
                      '${dateTime.day}, ${dateTime.month}, ${dateTime.year}';
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}
