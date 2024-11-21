import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_field_title.dart';
import 'package:familystars_2/ui/commons/text_widgets/common_text_form_field.dart';
import 'package:familystars_2/ui/screens/create_user_screen/widgets/create_user_child_select.dart';
import 'package:familystars_2/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget contains all fields necessary to create a new child

class CreateUserFields extends StatefulWidget {
  const CreateUserFields({Key? key}) : super(key: key);

  @override
  _CreateUserFieldsState createState() => _CreateUserFieldsState();
}

class _CreateUserFieldsState extends State<CreateUserFields> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createUserProviderRes = ref.watch(createUserScreenProvider);
      return Column(
        children: [
          CommonFieldTitle(title: AppConstants.fullname),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          // A child user just need a name
          CommonTextFormField(
            controller: createUserProviderRes.userNameController,
            focusNode: createUserProviderRes.userNameFocusNode,
            onChanged: (value) {
              return Validators.validateName(context, value!);
            },
            onFieldSubmitted: (value) {},
            validation: (value) {
              return Validators.validateName(context, value!);
            },
          ),
          // SizedBox(height: LayoutConstants.generalVerticalSpace,),
          // CommonFieldTitle(title: AppConstants.familiar),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          CreateUserChildSelect(),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),
          CommonFieldTitle(title: AppConstants.dob),
          SizedBox(
            height: LayoutConstants.generalVerticalSpace,
          ),

          // Select birthdate widget

          SizedBox(
            height: 180,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: Brightness.light,
              ),
              child: CupertinoDatePicker(
                initialDateTime: createUserProviderRes.dateTime,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (dateTime) => setState(() {
                  createUserProviderRes.setDob();
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}
