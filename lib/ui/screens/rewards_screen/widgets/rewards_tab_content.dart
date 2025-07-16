import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/ui/screens/rewards_screen/widgets/reward_category_tab.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';

// The widget holds the different tabs for reward content

class RewardsTabContent extends StatelessWidget {
  final String childId;
  const RewardsTabContent({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final rewardProviderRes = ref.watch(rewardScreenProvider);
        return FutureBuilder(
          future: rewardProviderRes.getUser(childId),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text("Loading...");
            return TabBarView(
              controller: rewardProviderRes.rewardController,
              children: [
                RewardCategoryTab(category: 'Cultura'),
                RewardCategoryTab(category: 'Experiencias'),
                RewardCategoryTab(category: 'Material'),
              ],
            );
          },
        );
      },
    );
  }
}
