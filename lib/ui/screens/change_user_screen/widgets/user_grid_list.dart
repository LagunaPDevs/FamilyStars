import 'package:familystars_2/ui/screens/change_user_screen/widgets/user_item_medallion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';

class UserGridList extends StatelessWidget {
  const UserGridList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final changeUserScrenRef = ref.watch(changeUserScreenProvider);
      return FutureBuilder(
        future: changeUserScrenRef.getUserList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return UserItemMedallion(user: snapshot.data[index]);
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
        },
      );
    });
  }
}
