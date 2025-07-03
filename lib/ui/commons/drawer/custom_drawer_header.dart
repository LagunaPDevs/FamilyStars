import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String logoPath;
  const CustomDrawerHeader({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [ColorConstants.blueColor, ColorConstants.blueGradient],
        ),
      ),
      child: SizedBox(
        child: Row(
          children: [
            Image.asset(
              logoPath,
              width: 100,
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              AppConstants.menu,
              style: TextStyle(
                  color: ColorConstants.whiteColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'KristenITC'),
            )
          ],
        ),
      ),
    );
  }
}
