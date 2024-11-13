import 'package:familystars_2/infrastructure/constants/app_constants.dart';
import 'package:familystars_2/infrastructure/constants/theme_constants.dart';
import 'package:familystars_2/infrastructure/services/shared_preference_services.dart';
import 'package:familystars_2/ui/screens/about_us_screen/about_us_screen.dart';
import 'package:familystars_2/ui/screens/activation_code_screen/activation_code_screen.dart';
import 'package:familystars_2/ui/screens/calendar_child_screen/calendar_child_screen.dart';
import 'package:familystars_2/ui/screens/calendar_screen/calendar_screen.dart';
import 'package:familystars_2/ui/screens/change_user_screen/change_user_screen.dart';
import 'package:familystars_2/ui/screens/choose_signup_method_screen/choose_signup_method_screen.dart';
import 'package:familystars_2/ui/screens/create_task_screen/create_task_screen.dart';
import 'package:familystars_2/ui/screens/create_user_screen/create_user_screen.dart';
import 'package:familystars_2/ui/screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:familystars_2/ui/screens/introduction_screen/introduction_screen.dart';
import 'package:familystars_2/ui/screens/login_screen/login_screen.dart';
import 'package:familystars_2/ui/screens/child_main_screen/child_main_screen.dart';
import 'package:familystars_2/ui/screens/main_screen/main_screen.dart';
import 'package:familystars_2/ui/screens/password_screen/password_screen.dart';
import 'package:familystars_2/ui/screens/registration_screen/registration_screen.dart';
import 'package:familystars_2/ui/screens/rewards_screen/rewards_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'infrastructure/constants/routes_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceService.getInstance();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, Widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.familyStars,
        theme: ThemeConstants.lightTheme,
        initialRoute: RoutesConstants.introductionScreen,
        routes: _buildNavigationRoutes(),
      ),
    );
  }

  Map<String, WidgetBuilder> _buildNavigationRoutes() {
    return <String, WidgetBuilder>{
      RoutesConstants.introductionScreen: (context) =>
          const IntroductionScreen(),
      RoutesConstants.loginScreen: (context) => const LoginScreen(),
      RoutesConstants.forgotPasswordScreen: (context) =>
          const ForgotPasswordScreen(),
      RoutesConstants.chooseSignUpScreen: (context) =>
          const ChooseSignUpMethodScreen(),
      RoutesConstants.registrationScreen: (context) =>
          const RegistrationScreen(),
      RoutesConstants.mainScreen: (context) => const MainScreen(),
      RoutesConstants.calendarScreen: (context) => const CalendarScreen(),
      RoutesConstants.rewardsScreen: (context) => const RewardsScreen(),
      RoutesConstants.activationCodeScreen: (context) =>
          const ActivationCodeScreen(),
      RoutesConstants.createUserScreen: (context) => const CreateUserScreen(),
      RoutesConstants.createTaskScreen: (context) => const CreateTaskScreen(),
      RoutesConstants.changeUserScreen: (context) => const ChangeUserScreen(),
      RoutesConstants.childMainScreen: (context) => const ChildMainScreen(),
      RoutesConstants.childCalendarScreen: (context) =>
          const CalendarChildScreen(),
      RoutesConstants.aboutUsScreen: (context) => const AboutUsScreen(),
      RoutesConstants.passwordScreen: (context) => const PasswordScreen()
    };
  }
}
