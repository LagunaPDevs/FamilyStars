import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget contains the tab title for each reward category

class RewardsTab extends StatefulWidget {
  const RewardsTab({super.key});

  @override
  _RewardsTabState createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> with TickerProviderStateMixin {
  late TabController _rewardController;
  @override
  void initState() {
    super.initState();
    _rewardController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Consumer(builder: (context, ref, child) {
        final rewardProviderRes = ref.watch(rewardScreenProvider);
        rewardProviderRes.rewardController = _rewardController;
        return AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(
              controller: _rewardController,
              isScrollable: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.yellowColor,
                      ),
              labelColor: ColorConstants.greyColor,
              labelStyle: TextStyle(
                  color: ColorConstants.greyColor,
                  fontSize: 14,
                  fontFamily: 'KristenITC',
                  fontWeight: FontWeight.bold),
                  unselectedLabelColor: ColorConstants.greyColor,
              labelPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              tabs: [
                Tab(
                  text: AppConstants.culture,
                ),
                Tab(
                  text: AppConstants.experiences,
                ),
                Tab(text: AppConstants.material)
              ],
            ),
          ),
        );
      }),
    );
    //   },
    // ));
  }
}
