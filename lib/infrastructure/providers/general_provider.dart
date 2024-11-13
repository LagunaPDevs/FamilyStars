import 'package:familystars_2/infrastructure/providers/activation_code_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/calendar_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/child_appabar_provider.dart';
import 'package:familystars_2/infrastructure/providers/create_task_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/create_user_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/forgot_password_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/password_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/registration_screen_provider.dart';
import 'package:familystars_2/infrastructure/providers/reward_screen_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_fields_screen_provider.dart';

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
