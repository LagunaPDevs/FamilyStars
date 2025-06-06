import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/models/user.dart' as local_user;
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class represents a widget that builds an AppBar representing a child
// user. It works as a menu which user can interact.
// Most of the actions are disable for a this type of user. It only have the
// ability of go to main screen, see company information or change to a parent
// user if the password is known

class ChildAppBar extends StatefulWidget {
  final String childId;
  const ChildAppBar({super.key, required this.childId});

  @override
  State<ChildAppBar> createState() => _ChildAppBarState();
}

class _ChildAppBarState extends State<ChildAppBar> {
  late String userStars;
  late String userId;
  DocumentSnapshot? documentSnapshot;
  late Future<local_user.UserModel> _futureData;
  final local_user.UserModel _user = local_user.UserModel();

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  // Retrieve specific data of a child
  Future<local_user.UserModel> _getAllUserData() async {
    Map<String, dynamic> mapData;
    await FirebaseServices.getDataList('users', widget.childId).then(
      (value) => {
        documentSnapshot = value,
        mapData = documentSnapshot!.data() as Map<String, dynamic>,
        _user.id = widget.childId,
        _user.name = mapData['name'],
        _user.email = mapData['email'],
        _user.familiar = mapData['familiar'],
        _user.stars = mapData['stars'],
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            ColorConstants.blueGradient,
            ColorConstants.blueColor,
          ])),
      child: Consumer(builder: (context, ref, child) {
        return AppBar(
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
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: Image.asset(
                                    ImageConstants.logoKids,
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
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppConstants.stars,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: ColorConstants.whiteColor,
                                        fontFamily: 'KristenITC'),
                                  ),
                                  ValueListenableBuilder<int>(
                                      valueListenable: _currentPage,
                                      builder: (BuildContext context, int value,
                                          Widget? child) {
                                        value = int.parse(_user.stars!);
                                        return Text('$value',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.whiteColor,
                                                fontFamily: 'KristenITC',
                                                fontSize: 18));
                                      }),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.blueColor,
                      ),
                    );
                  },
                ),
              ),
            ));
      }),
    );
  }
}
