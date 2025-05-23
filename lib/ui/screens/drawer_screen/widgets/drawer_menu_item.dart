import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const DrawerMenuItem({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              fontFamily: 'KristenITC', color: ColorConstants.blueColor)),
      onTap: onTap,
    );
  }
}
