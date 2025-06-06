import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_culture_tab.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_experience_tab.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_material_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The widget holds the different tabs for reward content

class RewardsTabContent extends StatefulWidget {
  final String childId;
  const RewardsTabContent({super.key, required this.childId});

  @override
  _RewardsTabContentState createState() => _RewardsTabContentState();
}

class _RewardsTabContentState extends State<RewardsTabContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final rewardProviderRes = ref.watch(rewardScreenProvider);
      return TabBarView(
        controller: rewardProviderRes.rewardController,
        children: [
          RewardCultureTab(
            userId: widget.childId,
          ),
          RewardExperienceTab(
            userId: widget.childId,
          ),
          RewardMaterialTab(
            userId: widget.childId,
          ),
        ],
      );
    });
  }
}
