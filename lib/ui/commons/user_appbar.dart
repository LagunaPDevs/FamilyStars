import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/models/user.dart' as local_user;
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This class represents a widget that builds an AppBar representing a parent
// user. It works as a menu which user can interact.
// It have most of the actions are activated for a this type of user. Edit
// personal information to be added in future versions

class UserAppBar extends StatefulWidget {
  const UserAppBar({super.key});

  @override
  State<UserAppBar> createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DocumentSnapshot? documentSnapshot;
  late Future<local_user.User> _futureData;
  final local_user.User _user = local_user.User();

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  // Retrieve specific data of a parent
  Future<local_user.User> _getAllUserData() async {
    Map<String, dynamic> mapData;
    await FirebaseServices.getDataList(
            'users', _firebaseAuth.currentUser?.uid)
        .then(
      (value) => {
        documentSnapshot = value,
        mapData = documentSnapshot!.data() as Map<String, dynamic>,
        _user.id = _firebaseAuth.currentUser?.uid,
        _user.name = mapData['name'],
        _user.email = mapData['email'],
        _user.familiar = mapData['familiar'],
        _user.dob = mapData['date_of_birth'],
      },
    );
    return _user;
  }

  @override
  void initState() {
    _futureData = _getAllUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? userreceived = ModalRoute.of(context)!.settings.arguments;
    String userpath = userreceived.toString();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            ColorConstants.blueGradient,
            ColorConstants.blueColor,
          ])),
      child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.blueColor.withOpacity(0.5),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future: _futureData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: ColorConstants.blueColor));
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image.asset(
                                  ImageConstants.logoParents,
                                  width: 80,
                                  height: 80,
                                )),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_user.name}',
                                  style: TextStyle(
                                      color: ColorConstants.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //SizedBox(height: LayoutConstants.generalItemSpace,),
                                Text('${_user.familiar}',
                                    style: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontSize: 18)),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  } else {
                    FirebaseServices.signOutAuthorizedUser();
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.blueColor,
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }
}
