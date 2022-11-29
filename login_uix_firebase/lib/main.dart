// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_desktop.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_mobile.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_page.dart';
import 'package:login_uix_firebase/pages/change_pw_page.dart';
import 'package:login_uix_firebase/pages/check_email_page.dart';
import 'package:login_uix_firebase/pages/dashboard_page.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_page.dart';
import 'package:login_uix_firebase/pages/login/login_page.dart';
import 'package:login_uix_firebase/pages/registerPage/register_page.dart';

import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_page.dart';
import 'package:login_uix_firebase/responsive_login_template.dart';
import 'package:login_uix_firebase/route.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Util {
  static void routeToWidget(context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: ControllerPage(),
        routes: {
          RouteName.changePWPage: (context) => const changePasswordPage(),
          RouteName.checkEmailPage: (context) => const CheckEmailView(),
          RouteName.dashboard: (context) => const DashboardPage(),
          RouteName.loginPage: (context) => const LoginPage(),
          RouteName.registerPage: (context) => const RegisterPage(),
          RouteName.landingPage: (context) => const LandingPage(),
          RouteName.editProfilePage: (context) => const EditProfilePage(),
          RouteName.viewProfilePage: (context) => const ViewProfilePage(),
          RouteName.controllerPage: (context) => const ControllerPage(),
        });
  }
}
