import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:familystars_2/infrastructure/models/event.dart';
import 'package:familystars_2/infrastructure/models/task.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_animated_alert_dialog.dart';
import 'package:familystars_2/ui/commons/alert_dialog_widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:familystars_2/infrastructure/models/user.dart' as local_user;
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This class contains multiple operations with Firebase database

class FirebaseServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final EmailAuth emailAuth = EmailAuth(sessionName: 'Test email');

  // LOGIN : Login User With Email-Id and Password Credentials
  static Future<bool> loginUserWithFirebaseEmailCredentials(
      BuildContext context, String id, String password) async {
    try {
      //---- Login starts
      CustomLoading.progressDialog(true, context);

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: id, password: password);

      CustomLoading.progressDialog(false, context);
      //---- Login ends

      // If User Email-Id and Password is matched
      if (userCredential.user != null) {
        print('LOGIN SUCCESSFULLY');
        await SharedPreferenceService()
            .saveUser(_firebaseAuth.currentUser!.uid.toString());
        return true;
      } else {
        print('LOGIN FAILED');
        return false;
      }
      // If error from Firebase
    } on FirebaseAuthException catch (e) {
      print('LOGIN FAILED :' '\n' 'ERROR: ${e.toString()}');
      CustomLoading.progressDialog(false, context);
      CustomAnimatedAlertDialog(
              context: context,
              title: "Error",
              content: 'Credenciales incorrectos')
          .show();
      return false;
      // If something wrong and user wont be able to login
    } catch (e) {
      print('LOGIN FAILED :' '\n' 'ERROR: ${e.toString()}');
      CustomLoading.progressDialog(false, context);
      CustomAnimatedAlertDialog(
              context: context,
              title: "Error",
              content: e.toString().split("]")[1])
          .show();
      return false;
    }
  }

  // REGISTER : send code OTP to user email
  static Future<void> verifyUserEmailAccount(BuildContext context,
      String emailAccount, String destinationWidgetRoute) async {
    print(emailAccount);
    bool sendOtp =
        await emailAuth.sendOtp(recipientMail: emailAccount, otpLength: 6);

    if (sendOtp) {
      Navigator.pushNamed(context, destinationWidgetRoute);
      print('REGISTRATION : Code is Send to user device');
    }
  }

  /// REGISTER : register email-password user. Throws an error if user exists in the database
  static Future<dynamic> registerUserWithFirebaseEmailCredentials(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await SharedPreferenceService()
            .saveUser(userCredential.user?.uid.toString() ?? "");
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('REGISTRATION : => ERROR:  $e');

      CustomLoading.progressDialog(false, context);

      CustomAnimatedAlertDialog(
              context: context,
              title: e.message,
              content: e.toString().split("]")[1])
          .show();
      return e.message;
    } catch (error) {
      print('REGISTRATION : => ERROR:  $error');

      CustomLoading.progressDialog(false, context);

      CustomAnimatedAlertDialog(
              context: context,
              title: "Registration failed",
              content: error.toString().split("]")[1])
          .show();
      return false;
    }
  }

  // GOOGLE SIGN-UP : direct sign by user google account
  static Future<bool> signUpWithFirebaseGoogleCredentials(
      BuildContext context) async {
    CustomLoading.progressDialog(true, context);

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    CustomLoading.progressDialog(false, context);

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          await SharedPreferenceService()
              .saveUser(userCredential.user?.uid.toString() ?? "");
          final fullName = googleSignInAccount.displayName ?? '';
          final emailId = googleSignInAccount.email;
          const password = '';
          await saveUserData(
              name: fullName,
              email: emailId,
              password: password,
              familiar: 'Otro',
              date_of_birth: '1,1,2000');
          print('REGISTER SUCCESSFULLY');
          return true;
        } else {
          return false;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
        print('REGISTRATION : => ERROR:  $e');

        CustomLoading.progressDialog(false, context);

        CustomAnimatedAlertDialog(
                context: context,
                title: "Registration Failed",
                content: e.toString().split("]")[1])
            .show();
        return false;
      } catch (e) {
        print('REGISTRATION : => ERROR:  $e');

        CustomLoading.progressDialog(false, context);

        CustomAnimatedAlertDialog(
                context: context,
                title: "Registration Failed",
                content: e.toString().split("]")[1])
            .show();
        // handle the error here
        return false;
      }
    } else {
      return false;
    }
  }

  //FACEBOOK SIGN-UP : direct sign by user facebook account
  static Future<bool> signUpWithFirebaseFacebookCredentials(
      BuildContext context) async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken?.tokenString ?? "");
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        await SharedPreferenceService()
            .saveUser(userCredential.user?.uid.toString() ?? "");
        final fullName = userData['name'] ?? '';
        final emailId = userData['email'] ?? '';
        const password = '';
        await saveUserData(
            name: fullName,
            email: emailId,
            password: password,
            familiar: 'Otro',
            date_of_birth: '1,1,2000');
        print('REGISTER SUCCESSFULLY');
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
      print('REGISTRATION : => ERROR:  $e');

      CustomLoading.progressDialog(false, context);

      CustomAnimatedAlertDialog(
              context: context,
              title: "Registration Failed",
              content: e.toString().split("]")[1])
          .show();
      return false;
    } catch (e) {
      print('REGISTRATION : => ERROR:  $e');

      CustomLoading.progressDialog(false, context);

      CustomAnimatedAlertDialog(
              context: context,
              title: "Registration Failed",
              content: e.toString().split("]")[1])
          .show();
      // handle the error here
      return false;
    }
  }

  // FIREBASE : Sign-out current user
  static Future<void> signOutAuthorizedUser() async {
    await _firebaseAuth.signOut();
    print('SIGN-OUT :  User sign-out successfully');
  }

  //FIREBASE : re-set password
  static Future<void> resetPassword(
      BuildContext context, String emailId) async {
    await _firebaseAuth
        .sendPasswordResetEmail(email: emailId)
        .then(
          (value) => {
            print(emailId),
            print('FORGET PASSWORD:  => LINK SEND TO YOUR EMAIL'),
          },
        )
        .onError((error, stackTrace) => {
              CustomAnimatedAlertDialog(
                      context: context,
                      title: "Error",
                      content:
                          'No se ha podido enviar reseteo de la contraseña')
                  .show()
            });
  }

  // FIREBASE FIRE_STORE: Storing User Data
  static Future<bool> saveUserData({
    String? name,
    String? email,
    String? familiar,
    String? password,
    String? role,
    String? date_of_birth,
  }) async {
    Map<String, dynamic> userData = {
      'id': _firebaseAuth.currentUser?.uid,
      'name': name,
      'email': email,
      'password': password,
      'familiar': familiar,
      'parent': '',
      'date_of_birth': date_of_birth,
      'stars': '0',
      'tasks': [],
    };
    try {
      _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set(userData);
      return true;
    } catch (error) {
      return false;
    }
  }

  // FIREBASE FIRE_STORE: Set Social User Password
  static Future<bool> saveUserPassword(
      String name, String email, String password) async {
    Map<String, dynamic> userData = {
      'id': _firebaseAuth.currentUser?.uid,
      'name': name,
      'email': email,
      'password': password,
      'familiar': 'Otro',
      'parent': '',
      'date_of_birth': '1,1,2000',
      'stars': '0',
      'tasks': [],
    };
    try {
      _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser?.uid)
          .set(userData);
      return true;
    } catch (error) {
      return false;
    }
  }

  // FIREBASE FIRE-STORE: Take data of a collection
  static Future<DocumentSnapshot> getDataList(
      String collection, String? documentId) async {
    CollectionReference data = _firebaseFirestore.collection(collection);
    return data.doc(documentId).get();
  }

  // FIREBASE FIRE-STORE: Add a new child user
  static Future<bool> addChildUserToFirestore(
      BuildContext context, String name, String familiar, String dob) async {
    DocumentSnapshot? documentSnapshot;
    local_user.UserModel user = local_user.UserModel();
    // TODO: CHECK NULL OPERATOR
    Map<String, dynamic> mapData;
    await FirebaseServices.getDataList('users', _firebaseAuth.currentUser?.uid)
        .then(
      (value) => {
        documentSnapshot = value,
        mapData = documentSnapshot!.data() as Map<String, dynamic>,
        user.id = _firebaseAuth.currentUser?.uid,
        user.name = mapData['name'],
        user.email = mapData['email'],
        user.familiar = mapData['familiar'],
        user.dob = mapData['date_of_birth'],
      },
    );
    Map<String, dynamic> userData = {
      'name': name,
      'email': '',
      'password': '',
      'familiar': familiar,
      'parent': _firebaseAuth.currentUser?.uid,
      'date_of_birth': dob,
      'stars': '0',
      'tasks': [],
    };
    try {
      await _firebaseFirestore.collection('users').add(userData);
      return true;
    } catch (e) {
      return false;
    }
  }

  // FIREFASE FIRESTORE: Add a new task to a child
  static Future<bool> addNewTaskToChild(
      String owner,
      String assigned,
      String assignedName,
      String name,
      String category,
      String date,
      String stars) async {
    Task task = Task();
    List<Task> listTask = [];

    TaskEvent taskEvent = TaskEvent();

    Map<String, dynamic> taskData = {
      'created': Timestamp.fromDate(DateTime.now()),
      'owner': _firebaseAuth.currentUser?.uid,
      'assigned': assigned,
      'assigned_name': assignedName,
      'name': name,
      'category': category,
      'date': date,
      'stars': stars,
      'state': 'Incompleta'
    };
    task.created = Timestamp.fromDate(DateTime.now()).toString();
    task.owner = _firebaseAuth.currentUser?.uid;
    task.assigned = assigned;
    task.assignedName = assignedName;
    task.name = name;
    task.category = category;
    task.date = date;
    task.stars = stars;
    task.state = 'Incompleta';

    Map<String, dynamic> eventData = {
      'date': date,
      'created': Timestamp.fromDate(DateTime.now()),
      'owner': _firebaseAuth.currentUser?.uid,
      'assigned': assigned,
      'assigned_name': assignedName,
      'task_name': name,
      'task_state': 'Incompleta',
      'task_stars': stars,
    };

    listTask.add(task);
    try {
      _firebaseFirestore.collection('tasks').add(taskData).then((value) => {
            _firebaseFirestore.collection('users').doc(assigned).update({
              'tasks': FieldValue.arrayUnion([value.id])
            }),
            _firebaseFirestore
                .collection('users')
                .doc(_firebaseAuth.currentUser?.uid)
                .update({
              'tasks': FieldValue.arrayUnion([value.id])
            }),
            // BEFORE REMOVING THIS REMEMBER TO CALL ADD EVENT ANYTIME CREATING NEW TASK
            _firebaseFirestore.collection('event').add(eventData).then(
                (event) => _firebaseFirestore
                    .collection('event')
                    .doc(event.id)
                    .update({'task_id': value.id})),
          });
      return true;
    } catch (error) {
      return false;
    }
  }

  // FIREFASE FIRESTORE: Add a task event
  static Future<bool> createNewEvent(
      String date,
      String owner,
      String assigned,
      String assignedName,
      String taskId,
      String taskName,
      String taskState,
      String taskStars) async {
    TaskEvent event = TaskEvent(
      owner: _firebaseAuth.currentUser?.uid,
      created: DateTime.now().toString(),
      assigned: assigned,
      assignedName: assignedName,
      taskName: taskName,
      date: date,
      taskId: taskId,
      taskState: taskState,
      taskStars: taskStars,
    );
    List<TaskEvent> listEvent = [];
    Map<String, dynamic> eventData = {
      'date': date,
      'created': Timestamp.fromDate(DateTime.now()),
      'owner': _firebaseAuth.currentUser?.uid,
      'assigned': assigned,
      'assigned_name': assignedName,
      'task_id': taskId,
      'task_name': taskName,
      'task_state': taskState,
      'task_stars': taskStars,
    };
    event.owner = _firebaseAuth.currentUser?.uid;
    event.created = DateTime.now().toString();
    event.assigned = assigned;
    event.assignedName = assignedName;
    event.taskName = taskName;
    event.date = date;
    event.taskId = taskId;
    event.taskState = taskState;
    event.taskStars = taskStars;

    listEvent.add(event);
    try {
      _firebaseFirestore.collection('event').add(eventData);
      return true;
    } catch (error) {
      return false;
    }
  }
}
