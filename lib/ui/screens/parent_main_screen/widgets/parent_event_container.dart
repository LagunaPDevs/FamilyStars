import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/commons/card_widgets/pink_gradient_card.dart';
import 'package:familystars_2/ui/screens/parent_main_screen/widgets/event_tile_item.dart';

// This widget shows a container with all the events related to an specific
// parent user.
// This events are related with the task it assign to multiple child user and
// also the changes in task state
// As well as 'CalendarScreen' a parent user can change task state using this
// container

class ParentEventContainer extends StatelessWidget {
  const ParentEventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final parentMainScreenProviderRef = ref.watch(parentMainScreenProvider);
        return PinkGradientCard(
          child: ListView(
            children: [
              Text(
                AppConstants.eventList,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              StreamBuilder(
                stream: parentMainScreenProviderRef.buildUserEventList(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: ColorConstants.blueColor),
                    );
                  } else {
                    Text(
                      AppConstants.noData,
                      textAlign: TextAlign.center,
                    );
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        EventTileItem(event: snapshot.data[index]),
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
