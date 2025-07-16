import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';

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
    return Consumer(
      builder: (context,ref, child) {
        final logInProviderRes = ref.watch(logInScreenProvider);
        return Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: GestureDetector(
                    onTap: () => logInProviderRes.loginWithFacebook(context),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(ImageConstants.facebookIcon),
                      radius: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: LayoutConstants.generalItemSpace,
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () => logInProviderRes.loginWithGoogle(context),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(ImageConstants.googleIcon),
                      radius: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
