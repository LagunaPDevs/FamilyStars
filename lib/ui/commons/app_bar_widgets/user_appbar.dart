import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/ui/commons/app_bar_widgets/custom_app_bar.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';


// This class represents a widget that builds an AppBar representing a parent
// user. It works as a menu which user can interact.
// It have most of the actions are activated for a this type of user. Edit
// personal information to be added in future versions

class ParentAppBar extends StatefulWidget {
  const ParentAppBar({super.key});

  @override
  State<ParentAppBar> createState() => _ParentAppBarState();
}

class _ParentAppBarState extends State<ParentAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentAppBarProviderRef = ref.watch(parentAppBarProvider);
        return CustomAppBar(
            isLoading: parentAppBarProviderRef.isLoading,
            logoPath: ImageConstants.logoParents,
            user: parentAppBarProviderRef.getParentUser());
      },
    );
  }
}
