// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_uix_firebase/pages/change_pw_page.dart';
import 'package:login_uix_firebase/pages/check_email_page.dart';
import 'package:login_uix_firebase/pages/dashboard_page.dart';
import 'package:login_uix_firebase/pages/delete_account_page.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';
import 'package:login_uix_firebase/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/pages/main_page.dart';
import 'package:login_uix_firebase/pages/manage_sidebar/manage_client_type_page.dart';
import 'package:login_uix_firebase/pages/manage_sidebar/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/manage_sidebar/manage_servicesCategory_page.dart';
import 'package:login_uix_firebase/pages/manage_sidebar/manage_services_page.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';
import 'package:login_uix_firebase/pages/register_page.dart';
import 'package:login_uix_firebase/pages/user_table_page.dart';
import 'package:login_uix_firebase/routes/page_route.dart';
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
        // initialRoute: ControllerPage(),
        routes: {
          MainPage.routeName: (context) => const MainPage(),
          DashboardPage.routeName: (context) => const DashboardPage(),
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          DeleteAccount.routeName: (context) => const DeleteAccount(),
          CheckEmailView.routeName: (context) => const CheckEmailView(),
          changePasswordPage.routeName: (context) => const changePasswordPage(),
          ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          UserTablePage.routeName: (context) => const UserTablePage(),
          ManageRoles.routeName: (context) => const ManageRoles(),
          ManageClients.routeName: (context) => const ManageClients(),
          ManageServices.routeName: (context) => const ManageServices(),
          ManageServiceCategory.routeName: (context) =>
              const ManageServiceCategory(),
          ControllerPage.routeName: (context) => const ControllerPage(),
        });
  }
}
