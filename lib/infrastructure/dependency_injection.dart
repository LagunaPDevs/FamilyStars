import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:familystars_2/infrastructure/data_sources/auth_data_source.dart';
import 'package:familystars_2/infrastructure/data_sources/task_data_source.dart';
import 'package:familystars_2/infrastructure/data_sources/task_event_data_source.dart';
import 'package:familystars_2/infrastructure/data_sources/user_data_source.dart';

import 'package:familystars_2/infrastructure/domain/repositories/auth_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_event_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/task_repository.dart';
import 'package:familystars_2/infrastructure/domain/repositories/user_repository.dart';

import 'package:familystars_2/infrastructure/domain/use_cases/add_new_task_to_child_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/facebook_sso_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/get_user_event_list_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/get_user_tasks_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/google_sso_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/login_with_email_credentials_user_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/logout_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/sign_up_with_email_credentials_use_case.dart';
import 'package:familystars_2/infrastructure/domain/use_cases/update_task_use_case.dart';
import 'package:familystars_2/infrastructure/providers/activation_code_screen_provider.dart';

import 'package:familystars_2/infrastructure/providers/calendar_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/child_appabar_provider.dart';
import 'package:familystars_2/infrastructure/providers/create_task_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/create_user_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/forgot_password_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/password_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/registration_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/reward_screen_provider.dart';

import 'package:familystars_2/infrastructure/repositories/auth_repository_impl.dart';
import 'package:familystars_2/infrastructure/repositories/task_event_repository_impl.dart';
import 'package:familystars_2/infrastructure/repositories/task_repository_impl.dart';
import 'package:familystars_2/infrastructure/repositories/user_repository_impl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/login_fields_screen_provider.dart';

// This class manage all providers

final logInScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => LogInScreenProvider(ref));

final forgotPasswordScreenProvider = ChangeNotifierProvider.autoDispose(
    (ref) => ForgotPasswordScreenProvider(ref));

final registrationScreenProvider = ChangeNotifierProvider.autoDispose(
    (ref) => RegistrationScreenProvider(ref));

final activationCodeScreenProvider = ChangeNotifierProvider.autoDispose(
    (ref) => ActivationCodeScreenProvider(ref));

final createUserScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => CreateUserScreenProvider(ref));

final createTaskScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => CreateTaskScreenProvider(ref));

final passwordScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => PasswordScreenProvider(ref));

final rewardScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => RewardScreenProvider(ref));

final childAppBarProvider =
    ChangeNotifierProvider.autoDispose((ref) => ChildAppBarProvider(ref));

final calendarScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => CalendarScreenProvider(ref));

// firebase
final firebaseAuth = Provider<FirebaseAuth>((ref)=> FirebaseAuth.instance);
final  firebaseCrashlytics = Provider<FirebaseCrashlytics>((ref)=> FirebaseCrashlytics.instance);
final firebaseFirestore = Provider<FirebaseFirestore>((ref)=>  FirebaseFirestore.instance);

// data sources injection
final authDataSource = Provider<AuthDataSource>((ref) => AuthDataSourceImpl(
    firebaseAuth: ref.watch(firebaseAuth), firebaseCrashlytics: ref.watch(firebaseCrashlytics)));
final taskDataSource = Provider<TaskDataSource>((ref) => TaskDataSourceImpl(
    firebaseFirestore: ref.watch(firebaseFirestore),
    firebaseCrashlytics: ref.watch(firebaseCrashlytics)));
final taskEventDataSource = Provider<TaskEventDataSource>((ref) =>
    TaskEventDataSourceImpl(
        firebaseCrashlytics: ref.watch(firebaseCrashlytics),
        firebaseFirestore: ref.watch(firebaseFirestore)));
final userDataSource = Provider<UserDataSource>((ref) => UserDataSourceImpl(
    firebaseCrashlytics: ref.watch(firebaseCrashlytics),
    firebaseFirestore: ref.watch(firebaseFirestore)));

// repositories
final authRepository = Provider<AuthRepository>(
    (ref) => AuthRepositoryImpl(dataSource: ref.watch(authDataSource)));
final taskRepository = Provider<TaskRepository>(
    (ref) => TaskRepositoryImpl(dataSource: ref.watch(taskDataSource)));
final taskEventRepository = Provider<TaskEventRepository>((ref) =>
    TaskEventRepositoryImpl(dataSource: ref.watch(taskEventDataSource)));
final userRepository = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(dataSource: ref.watch(userDataSource)));

// use cases
final addNewTaskToChildUseCase = Provider<AddNewTaskToChildUseCase>((ref) =>
    AddNewTaskToChildUseCase(
        taskEventRepository: ref.watch(taskEventRepository),
        taskRepository: ref.watch(taskRepository),
        userRepository: ref.watch(userRepository)));
final facebookSSOUseCase = Provider<FacebookSsoUseCase>((ref)=> FacebookSsoUseCase(authRepository: ref.watch(authRepository), userRepository: ref.watch(userRepository)));
final getUserEventListUseCase = Provider<GetUserEventListUseCase>((ref)=> GetUserEventListUseCase(taskEventRepository: ref.watch(taskEventRepository)));
final getUserTasksUseCase = Provider<GetUserTasksUseCase>((ref)=> GetUserTasksUseCase(taskRepository: ref.watch(taskRepository)));
final googleSSOUseCase = Provider<GoogleSSOUseCase>((ref)=> GoogleSSOUseCase(authRepository: ref.watch(authRepository), userRepository: ref.watch(userRepository)));
final loginWithEmailCrendentialsUseCase = Provider<LoginWithEmailCredentialsUserCase>((ref)=> LoginWithEmailCredentialsUserCase(authRepository: ref.watch(authRepository)));
final signUpWithEmailCredentialsUseCase = Provider<SignUpWithEmailCredentialsUseCase>((ref)=> SignUpWithEmailCredentialsUseCase(authRepository: ref.watch(authRepository)));
final updateTaskUseCase = Provider<UpdateTaskUseCase>((ref)=> UpdateTaskUseCase(taskEventRepository: ref.watch(taskEventRepository)));
final logoutUseCase = Provider<LogoutUseCase>((ref)=> LogoutUseCase(authRepository: ref.watch(authRepository)));
