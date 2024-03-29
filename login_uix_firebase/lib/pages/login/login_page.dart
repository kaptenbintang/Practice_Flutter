import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/login/login_desktop.dart';
import 'package:login_uix_firebase/pages/login/login_mobile_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 246, 246),
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (ResponsiveWidget.isSmallScreen(context)) {
              return LoginMobileRiverpod();
            } else {
              return LoginDesktop2();
            }
          },
        ),
      ),
    );
  }
}
