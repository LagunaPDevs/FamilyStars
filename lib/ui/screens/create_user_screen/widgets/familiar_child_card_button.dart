import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamiliarChildCardButton extends StatelessWidget {
  final String familiar;
  const FamiliarChildCardButton({super.key, required this.familiar});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final createUserProviderRef = ref.watch(createUserScreenProvider);
        return GestureDetector(
          onTap: () => createUserProviderRef.setFamiliar(familiar),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: createUserProviderRef.familiarText == familiar
                    ? ColorConstants.yellowColor
                    : ColorConstants.blueColor),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                familiar,
                style:
                    TextStyle(color: ColorConstants.whiteColor, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
