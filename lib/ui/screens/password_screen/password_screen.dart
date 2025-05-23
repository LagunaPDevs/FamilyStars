import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:familystars_2/ui/screens/password_screen/widgets/password_screen_button.dart';
import 'package:familystars_2/ui/screens/password_screen/widgets/password_screen_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: UserAppBar()),
      drawer: DrawerScreen(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleText(title: AppConstants.setPassword),
                SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                PasswordScreenFields(),
                PasswordScreenButton(formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
