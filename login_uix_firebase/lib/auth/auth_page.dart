import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/login/login_desktop.dart';
import 'package:login_uix_firebase/pages/login/login_mobile_page.dart';
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
      return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return LoginMobile(showRegisterPage: toggleScreens);
            } else {
              return LoginDesktop(showRegisterPage: toggleScreens);
            }
          },
        ),
      );
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
