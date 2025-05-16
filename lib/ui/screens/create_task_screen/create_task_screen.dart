import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/create_task_button.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/create_task_fields.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// This class shows a screen where a parent user can add a task to a child

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: UserAppBar()),
      drawer: DrawerScreen(),
      floatingActionButton: CreateTaskButton(
        formKey: _formKey,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  //TitleText(title: AppConstants.addTask),
                  CreateTaskFields(),
                ],
              ),
            ),
          )),
    );
  }
}
