import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/infrastructure/models/reward.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:familystars_2/ui/commons/card_widgets/reward_card.dart';

class RewardTileItem extends StatelessWidget {
  final Reward reward;
  const RewardTileItem({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final rewardScreenProviderRef = ref.watch(rewardScreenProvider);
        return GestureDetector(
          onTap: () async {
            final result = rewardScreenProviderRef.onRewardClick(reward.stars ?? 0);
            if (result == false && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      ColorConstants.purpleGradient.withValues(alpha: .5),
                  content: SizedBox(
                      height: 100,
                      child: Text(AppConstants.notStars,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                ),
              );
            } else {
              if (context.mounted) {
                CustomChangeStateDialog(
                  context: context,
                  title: 'Reclamar premio',
                  content: '¿Quieres reclamar el premio \'${reward.name}\'?',
                  onOkTap: () async {
                    final claimReward = await rewardScreenProviderRef
                        .claimReward(rewardPoints: reward.stars ?? 0);
                    if (claimReward && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ).show();
              }
            }
          },
          child: RewardCard(
            name: reward.name ?? '',
            stars: reward.stars.toString(),
          ),
        );
      },
    );
  }
}
