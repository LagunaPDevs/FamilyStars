import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_change_state_dialog.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:familystars_2/ui/commons/card_widgets/reward_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget contains a Tab information with culture rewards available for a
// child

// If a item is clicked an child have enough stars, reward is reclaimed
// Otherwise app alerts to child it has not enough stars

class RewardCultureTab extends StatefulWidget {
  final String userId;
  const RewardCultureTab({Key? key, required this.userId}) : super(key: key);

  @override
  _RewardCultureTabState createState() => _RewardCultureTabState();
}

class _RewardCultureTabState extends State<RewardCultureTab> {
  Widget _buildRewardItem(BuildContext context, DocumentSnapshot document) {
    String userPath = widget.userId;
    FirebaseFirestore rootRef = FirebaseFirestore.instance;
    CollectionReference itemRef = rootRef.collection('users');
    String userStarsString = '';

    return Consumer(builder: (context, ref, child) {
      final childAppBarProviderRes = ref.watch(childAppBarProvider);
      return GestureDetector(
          onTap: () async {
            await itemRef
                .doc(userPath)
                .get()
                .then((value) => userStarsString = value['stars']);
            int userStars = int.parse(userStarsString);
            int rewardStars = int.parse(document['stars']);

            // If user have more stars than rewards stars, ask whether to reclaim
            // the reward
            if (userStars >= rewardStars) {
              int result = userStars - rewardStars;

              CustomChangeStateDialog(
                  context: context,
                  title: 'Reclamar premio',
                  content:
                      '¿Quieres reclamar el premio \'${document['name']}\'?',
                  onOkTap: () async {
                    // The stars subtracted from user stars
                    CustomLoading.progressDialog(true, context);
                    await itemRef
                        .doc(userPath)
                        .update({'stars': result.toString()});
                    childAppBarProviderRes.setChildStars(result.toString());
                    CustomLoading.progressDialog(false, context);
                    Navigator.popAndPushNamed(
                        context, RoutesConstants.rewardsScreen,
                        arguments: userPath);
                  }).show();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: ColorConstants.purpleGradient.withOpacity(0.5),
                content: Container(
                    height: 100,
                    child: Text(AppConstants.notStars,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ));
            }
          },
          child: RewardCard(name: document['name'], stars: document['stars']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('rewards')
                .where('category', isEqualTo: 'Cultura')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) return const Text('Loading');
              // Build list of culture rewards
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) =>
                    _buildRewardItem(context, snapshot.data.docs[index]),
              );
            })
      ],
    );
  }
}
