import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:familystars_2/ui/commons/app_bar_widgets/child_appbar.dart';
import 'package:familystars_2/ui/screens/child_drawer_screen/child_drawer_screen.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_tab.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_tab_content.dart';

// This widget represent a screen where a child user can reclaim rewards

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? unreceived = ModalRoute.of(context)!.settings.arguments;
    String userPath = unreceived.toString();
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          drawer: ChildDrawerScreen(
            childId: userPath,
          ),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: ChildAppBar(
                childId: userPath,
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                const SliverPinnedHeader(
                  child: RewardsTab(),
                ),
                SliverFillRemaining(
                  child: RewardsTabContent(childId: userPath),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
