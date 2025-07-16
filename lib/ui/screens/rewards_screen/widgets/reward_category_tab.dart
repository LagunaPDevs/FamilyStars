import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/reward_tile_item.dart';

class RewardCategoryTab extends StatelessWidget {
  final String category;
  const RewardCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final rewardScreenProviderRef = ref.watch(rewardScreenProvider);
        return ListView(
          children: [
            StreamBuilder(
              stream:
                  rewardScreenProviderRef.buildRewardListByCategory(category),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: ColorConstants.blueColor),
                  );
                }
                return ListView.builder(
                  // Build list of culture rewards
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      RewardTileItem(reward: snapshot.data[index]),
                );
              },
            )
          ],
        );
      },
    );
  }
}