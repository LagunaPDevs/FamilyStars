import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/ui/commons/child_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_child_screen.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_tab.dart';
import 'package:familystars_2/ui/screens/rewards_screen/widgets/rewards_tab_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

// This widget represent a screen where a child user can reclaim rewards

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  DocumentSnapshot? documentSnapshot;

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final Object? unreceived = ModalRoute.of(context)!.settings.arguments;
    String userPath = unreceived.toString();
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
          drawer: DrawerChildScreen(
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
          ));
    });
  }
}
