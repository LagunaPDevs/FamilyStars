import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/layout_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/ui/commons/text_widgets/title_text.dart';
import 'package:familystars_2/ui/commons/user_appbar.dart';
import 'package:familystars_2/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget allows to a parent user to change between child users

class ChangeUserScreen extends StatefulWidget {
  const ChangeUserScreen({Key? key}) : super(key: key);

  @override
  _ChangeUserScreenState createState() => _ChangeUserScreenState();
}

class _ChangeUserScreenState extends State<ChangeUserScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Widget _buildUserList(BuildContext context, DocumentSnapshot document) {
    String firstLater = document['name'][0];
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(context, RoutesConstants.childMainScreen,
                arguments: document.id);
          },
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstants.generateRandomUserColor(),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                firstLater,
                style: TextStyle(fontFamily: 'KristenITC', fontSize: 28),
              ),
            ),
          ),
        ),
        Text(document['name']),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          drawer: DrawerScreen(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(120), child: UserAppBar()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),
                TitleText(title: AppConstants.changeUser),
                SizedBox(
                  height: LayoutConstants.generalVerticalSpace,
                ),

                // Retrieve all children of an specific parent

                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('parent',
                            isEqualTo: _firebaseAuth.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildUserList(
                              context, snapshot.data.docs[index]);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
