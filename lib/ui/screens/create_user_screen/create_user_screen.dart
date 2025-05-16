import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/create_user_screen/widgets/create_user_button.dart';
import 'package:familystars_2/ui/screens/create_user_screen/widgets/create_user_fields.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class represents a screen where a parent user can create a new child
// user

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: UserAppBar()),
      drawer: DrawerScreen(),
      floatingActionButton: CreateUserButtons(
        formKey: _formKey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                TitleText(title: AppConstants.createUser),
                SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                CreateUserFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
