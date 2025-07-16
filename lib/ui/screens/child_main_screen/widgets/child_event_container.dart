import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/card_widgets/pink_gradient_card.dart';
import 'package:familystars_2/ui/screens/child_main_screen/widgets/child_event_tile_item.dart';

// This widget shows a container with all the events related to an specific
// child user
// As well as 'ChildCalendarScreen' a child user can change task state using
// this container

class ChildEventContainer extends StatelessWidget {
  final String userPath;
  const ChildEventContainer({super.key, required this.userPath});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final childMainScreenProviderRef = ref.watch(childMainScreenProvider);
        return PinkGradientCard(
          child: ListView(
            children: [
              Text(
                AppConstants.eventList,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              StreamBuilder(
                stream:
                    childMainScreenProviderRef.buildChildEventList(userPath),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: ColorConstants.blueColor));
                  }
                  // build list of items
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        ChildEventTileItem(event: snapshot.data[index]),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
