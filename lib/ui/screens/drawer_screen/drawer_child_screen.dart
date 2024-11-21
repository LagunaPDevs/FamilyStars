import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/models/user.dart' as local_user;
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/constants/image_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This widget is the drawer menu of a child user, it id is necessary.
// The id is received as an argument.
//
// Most of the functionalities of the menu are not available for a child user
// It can go to child main screen or change user if the required password is
// known

class DrawerChildScreen extends StatefulWidget {
  final String childId;
  const DrawerChildScreen({Key? key, required this.childId}) : super(key: key);

  @override
  _DrawerChildScreenState createState() => _DrawerChildScreenState();
}

class _DrawerChildScreenState extends State<DrawerChildScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DocumentSnapshot? documentSnapshot;
  late Future<local_user.User> _futureData;
  TextEditingController changeUserController = TextEditingController();
  FocusNode changeUserFocus = FocusNode();
  local_user.User _user = local_user.User();
  late String userId;
  late String pswd;
  ValueNotifier<int> _currentPage = ValueNotifier(0);

  // Retrieve child user data
  Future<local_user.User> _getAllUserData() async {
    Map<String, dynamic> mapData;
    await FirebaseServices.getDataList('users', widget.childId).then(
      (value) => {
        documentSnapshot = value,
        mapData = documentSnapshot!.data() as Map<String, dynamic>,
        _user.id = widget.childId,
        _user.name = mapData['name'],
        _user.parent = mapData['parent'],
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
    return Consumer(builder: (context, ref, child) {
      return Drawer(
          child: FutureBuilder(
              future: _futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: ColorConstants.blueColor));
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                          decoration: const BoxDecoration(
                              //color: ColorConstants.blueColor,
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                ColorConstants.blueColor,
                                ColorConstants.blueGradient
                              ])),
                          // Actions of the drawer
                          // -------------
                          child: Column(
                            children: [
                              Row(children: [
                                Image.asset(
                                  ImageConstants.logoKids,
                                  width: 100,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                const Text(
                                  AppConstants.menu,
                                  style: TextStyle(
                                      color: ColorConstants.whiteColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'KristenITC'),
                                )
                              ])
                            ],
                          )),
                      ListTile(
                        title: const Text(
                          AppConstants.main,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, RoutesConstants.childMainScreen,
                              arguments: widget.childId);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          AppConstants.editUser,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text(
                          AppConstants.createUser,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () {
                          deniedAccess(context);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          AppConstants.changeUser,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () async {
                          // Async function which retrieve the password for
                          // current parent user
                          String parentPwd = '';
                          await _firebaseFirestore
                              .collection('users')
                              .doc(_firebaseAuth.currentUser!.uid)
                              .get()
                              .then(
                                (value) => parentPwd = value['password'],
                              )
                              .then((value) => {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Center(
                                                child: Text(
                                                    AppConstants.changeUser)),
                                            content: TextField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    pswd = value;
                                                  });
                                                },
                                                controller:
                                                    changeUserController,
                                                focusNode: changeUserFocus,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      AppConstants.password,
                                                )),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        // if password fits go to parent main screen
                                                        if (pswd == parentPwd) {
                                                          Navigator.popAndPushNamed(
                                                              context,
                                                              RoutesConstants
                                                                  .mainScreen);
                                                        } else {
                                                          deniedAccess(context);
                                                        }
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            //border: Border.all(color: ColorConstants.blueColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              AppConstants.ok,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ))),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            //border: Border.all(color: ColorConstants.blueColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              AppConstants
                                                                  .cancel,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )))
                                                ],
                                              )
                                            ],
                                          );
                                        })
                                  });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child:
                            Divider(height: 1, color: ColorConstants.blueColor),
                      ),
                      ListTile(
                        title: const Text(
                          AppConstants.aboutUs,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () {
                          deniedAccess(context);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          AppConstants.logOut,
                          style: TextStyle(fontFamily: 'KristenITC'),
                        ),
                        onTap: () {
                          deniedAccess(context);
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.blueColor,
                  ),
                );
              })
          // -------------
          );
    });
  }

  // Alert dialog warns to child user that action is not permitted
  deniedAccess(BuildContext context) {
    CustomAnimatedAlertDialog(
            title: AppConstants.deniedAccess,
            content: AppConstants.notPermitted,
            context: context)
        .show();
  }
}
