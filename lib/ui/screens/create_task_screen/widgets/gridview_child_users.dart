import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget retrieve all child users owned by a parent, it is use to assign
// a task to a child user

class GridViewChildUsers extends StatefulWidget {
  const GridViewChildUsers({super.key});

  @override
  _GridViewChildUsersState createState() => _GridViewChildUsersState();
}

class _GridViewChildUsersState extends State<GridViewChildUsers> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('parent', isEqualTo: _firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return _buildUserList(context, snapshot.data.docs[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
          );
        });
  }
  // Build a grid view of child users available

  Widget _buildUserList(BuildContext context, DocumentSnapshot document) {
    return Consumer(
      builder: (context, ref, child) {
        final createTaskProvider = ref.watch(createTaskScreenProvider);
        return GestureDetector(
          onTap: () {
            createTaskProvider.setAssigned(document.id);
            createTaskProvider.setAssignedName(document['name']);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.blueColor),
                borderRadius: BorderRadius.circular(20),
                color: ColorConstants.blueColor.withOpacity(0.3)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(
                document['name'],
                style: TextStyle(fontFamily: 'KristenITC', fontSize: 14, color: ColorConstants.blueColor),
              )),
            ),
          ),
        );
      },
    );
  }
}
