import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/user.dart';

class ChildUserGridItem extends StatelessWidget {
  final UserModel user;
  const ChildUserGridItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskProvider = ref.watch(createTaskScreenProvider);
      return GestureDetector(
        onTap: () {
          createTaskProvider.setAssigned(user.id ?? "");
          createTaskProvider.setAssignedName(user.name ?? "");
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.blueColor),
              borderRadius: BorderRadius.circular(20),
              color: ColorConstants.blueColor.withValues(alpha: .3)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
              user.name ?? "",
              style: TextStyle(
                  fontFamily: 'KristenITC',
                  fontSize: 14,
                  color: ColorConstants.blueColor),
            )),
          ),
        ),
      );
    });
  }
}
