import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// First screen that is shown when the user installs the app
// This is screen is not shown if the user has been already authenticated
// on the device

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();

    // If user has logged previously it leads to it main screen
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (SharedPreferenceService().getUser() != null) {
        //await FirebaseServices.getDataList("users", FirebaseAuth.instance.currentUser!.uid);
        Navigator.of(context).popAndPushNamed(RoutesConstants.mainScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                ColorConstants.blueColor,
                ColorConstants.blueGradient
              ])),
          // If the user has not logged previously the screen is shown
          child: SharedPreferenceService().getUser() == null
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      SizedBox(
                          width: 200,
                          child: Image.asset(ImageConstants.logoFamilyStars)),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .popAndPushNamed(RoutesConstants.loginScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              AppConstants.start,
                              style: TextStyle(
                                  color: ColorConstants.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'KristenITC'),
                            ),
                          ))
                    ],
                  ),
                )
              : const CircularProgressIndicator(
                  color: ColorConstants.whiteColor),
        ),
      );
    });
  }
}
