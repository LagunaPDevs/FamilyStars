import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationFamiliarBox extends StatelessWidget {
  final String familiar;

  const RegistrationFamiliarBox({super.key, required this.familiar});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final registrationProviderRes = ref.watch(registrationScreenProvider);
        return GestureDetector(
          onTap: () => registrationProviderRes.setFamiliarText(familiar),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: boxColor(
                    isSelected:
                        registrationProviderRes.familiarText == familiar)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                familiar,
                style:
                    TextStyle(color: ColorConstants.whiteColor, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}

Color boxColor({required bool isSelected}) {
  return isSelected ? ColorConstants.yellowColor : ColorConstants.blueColor;
}
