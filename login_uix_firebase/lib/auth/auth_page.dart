import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/login/loginWidget/login_desktop.dart';
import 'package:login_uix_firebase/pages/loginPage/loginWidget/login_mobile_page.dart';
import 'package:login_uix_firebase/pages/loginPage/login_page.dart';
import 'package:login_uix_firebase/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
//intially show the login page

  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginDesktop(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
