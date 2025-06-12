import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:familystars_2/infrastructure/dependency_injection.dart';
import 'package:familystars_2/ui/screens/create_task_screen/widgets/child_user_grid_item.dart';


// This widget retrieve all child users owned by a parent, it is use to assign
// a task to a child user

class GridViewChildUsers extends StatefulWidget {
  const GridViewChildUsers({super.key});

  @override
  _GridViewChildUsersState createState() => _GridViewChildUsersState();
}

class _GridViewChildUsersState extends State<GridViewChildUsers> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final createTaskScreenRef = ref.watch(createTaskScreenProvider);
      return FutureBuilder(
          future: createTaskScreenRef.getChildList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ChildUserGridItem(user: snapshot.data[index]);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
            );
          });
    });
  }
}
