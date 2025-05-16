import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';

// This class represents a widget that holds company an contact information

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(120), child: UserAppBar()),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              TitleText(title: AppConstants.softchanging),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              SizedBox(
                width: 300,
                child: Image.asset(ImageConstants.softchangingLogo),
              ),
              SizedBox(
                height: LayoutConstants.generalVerticalSpace,
              ),
              Text('C/Innovación 1'),
              Text('+34 666 555 888'),
            ],
          ),
        ),
      ),
    );
  }
}
