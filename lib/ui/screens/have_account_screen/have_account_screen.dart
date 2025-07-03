import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';

// Simple widget that lead user to 'LoginScreen'

class HaveAccountScreen extends StatelessWidget {
  const HaveAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(AppConstants.yesAccount),
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, RoutesConstants.loginScreen),
            child: Text(
              AppConstants.signIn,
              style: TextStyle(
                  color: ColorConstants.blueColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
