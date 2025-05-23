import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:flutter/material.dart';

// The class contains circular button widgets which permit to the user to be
// logged with Social Media credentials (Facebook, Google, Twitter)

class SocialMediaButtonScreen extends StatefulWidget {
  const SocialMediaButtonScreen({super.key});

  @override
  _SocialMediaButtonScreenState createState() =>
      _SocialMediaButtonScreenState();
}

class _SocialMediaButtonScreenState extends State<SocialMediaButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ---
            // Facebook
            // ---
            SizedBox(
              child: GestureDetector(
                onTap: () async {
                  bool isLoggedIn = await FirebaseServices
                      .signUpWithFirebaseFacebookCredentials(context);
                  if (isLoggedIn) {
                    Navigator.pushReplacementNamed(
                        context, RoutesConstants.passwordScreen);
                  }
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstants.facebookIcon),
                  radius: 30,
                ),
              ),
            ),
            SizedBox(
              width: LayoutConstants.generalItemSpace,
            ),
            // ---
            // Google
            // ---
            Container(
              child: GestureDetector(
                onTap: () async {
                  bool isLoggedIn = await FirebaseServices
                      .signUpWithFirebaseGoogleCredentials(context);
                  if (isLoggedIn) {
                    Navigator.pushReplacementNamed(
                        context, RoutesConstants.passwordScreen);
                  }
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstants.googleIcon),
                  radius: 30,
                ),
              ),
            ),
            SizedBox(
              width: LayoutConstants.generalItemSpace,
            ),
            // ---
            // Twitter
            // ---
            // Not implemented yet
            Container(
              child: GestureDetector(
                onTap: () {
                  CustomAnimatedAlertDialog(
                          title: 'Función deshabilitada',
                          content: 'Función desahbilitada en la versión beta',
                          context: context)
                      .show();
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstants.twitterIcon),
                  radius: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
