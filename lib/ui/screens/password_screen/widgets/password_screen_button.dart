import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familystars_2/infrastructure/constants/color_constants.dart';
import 'package:familystars_2/infrastructure/models/user.dart' as local_user;
import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/routes_constants.dart';
import 'package:familystars_2/infrastructure/providers/general_provider.dart';
import 'package:familystars_2/infrastructure/services/firebase_services.dart';
import 'package:familystars_2/ui/commons/button_widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordScreenButton extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  const PasswordScreenButton({Key? key, this.formKey}) : super(key: key);

  @override
  State<PasswordScreenButton> createState() => _PasswordScreenButtonState();
}

class _PasswordScreenButtonState extends State<PasswordScreenButton> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DocumentSnapshot? documentSnapshot;
  late Future<local_user.User> _futureData;
  final local_user.User _user = local_user.User();

  ValueNotifier<int> _currentPage = ValueNotifier(0);

  // Retrieve specific data of a parent
  Future<local_user.User> _getAllUserData() async {
    Map<String, dynamic> mapData;
    await FirebaseServices.getDataList('users', _firebaseAuth.currentUser!.uid)
        .then(
      (value) => {
        documentSnapshot = value,
        mapData = documentSnapshot!.data() as Map<String, dynamic>,
        _user.id = _firebaseAuth.currentUser!.uid,
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
    return Consumer(builder: (context, watch, child) {
      final passwordProviderRes = watch.read(passwordScreenProvider);
      return FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator(color: ColorConstants.blueColor));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return CustomButton(
              onPressed: () async {
                // If fields are completed it check email-password
                if (widget.formKey!.currentState!.validate()) {
                  String password = passwordProviderRes.passwordController.text;
                  String? name = _user.name;
                  String? email = _user.email;
                  // Set user password
                  bool setPassword = await FirebaseServices.saveUserPassword(
                      name!, email!, password);
                  if (setPassword) {
                    // Go to main page if everything correct
                    Navigator.pushReplacementNamed(
                        context, RoutesConstants.mainScreen);
                  }
                }
              },
              title: AppConstants.signIn,
              buttonHeight: 50,
              fontSize: 18,
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.blueColor,
            ),
          );
        },
      );
    });
  }
}
