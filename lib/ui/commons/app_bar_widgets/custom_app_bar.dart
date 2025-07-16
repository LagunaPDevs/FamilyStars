import 'package:familystars_2/ui/commons/alert_dialog_widgets/app_bar_loading_skeleton.dart';
import 'package:flutter/material.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

// USE CHILD DRAWER SCREEN PROVIDER ?? RENAME ?? SAME FOR DRAWER AND FOR APPBAR, LAYOUT ??
class CustomAppBar extends StatelessWidget {
  final bool isLoading;
  final String logoPath;
  final Future<UserModel?> user;
  final Widget? widget;
  const CustomAppBar(
      {super.key,
      required this.isLoading,
      required this.logoPath,
      required this.user,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            ColorConstants.blueGradient,
            ColorConstants.blueColor,
          ],
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: snapshot.connectionState == ConnectionState.waiting &&
                          !snapshot.hasData
                      ? AppBarLoadingSkeleton()
                      : appBarContent(context,
                          logoPath: logoPath,
                          user: snapshot.data,
                          widget: widget));
            },
          ),
        ),
      ),
    );
  }
}

Widget appBarContent(BuildContext context,
    {required String logoPath, required UserModel? user, Widget? widget}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Image.asset(
          logoPath,
          width: 80,
          height: 80,
        ),
      ),
      SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user?.name ?? '',
            style: TextStyle(
                color: ColorConstants.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            user?.familiar ?? "Other",
            style: TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
          ),
        ],
      ),
      SizedBox(
        width: 80,
      ),
      widget ?? SizedBox()
    ],
  );
}
