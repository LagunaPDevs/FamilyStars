import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Thanks to this widget the number of stars for a task is set

class StarsButton extends StatefulWidget {
  const StarsButton({super.key});

  @override
  _StarsButtonState createState() => _StarsButtonState();
}

class _StarsButtonState extends State<StarsButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskProviderRes = ref.watch(createTaskScreenProvider);
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        GestureDetector(
            onTap: () {
              // subtract stars
              createTaskProviderRes.setStarsDown();
              createTaskProviderRes
                  .setStarsText(createTaskProviderRes.stars.toString());
            },
            child: Text('-',
                style: TextStyle(
                  color: ColorConstants.greyColor,
                  fontSize: 40,
                ))),
        SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        Stack(alignment: Alignment.center, children: [
          // show number of stars
          Image.asset(
            ImageConstants.simpleStar,
            width: 50,
            height: 50,
          ),
          Text(
            createTaskProviderRes.starsText,
            style: TextStyle(fontSize: 19, color: ColorConstants.greyColor),
          ),
        ]),
        SizedBox(
          width: LayoutConstants.generalItemSpace,
        ),
        GestureDetector(
            onTap: () {
              // add stars
              createTaskProviderRes.setStarsUp();
              createTaskProviderRes
                  .setStarsText(createTaskProviderRes.stars.toString());
            },
            child: Text('+',
                style: TextStyle(
                  color: ColorConstants.greyColor,
                  fontSize: 30,
                ))),
      ]);
    });
  }
}
