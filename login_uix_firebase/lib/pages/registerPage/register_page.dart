import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/registerPage/register_desktop.dart';
import 'package:login_uix_firebase/pages/registerPage/register_mobile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return RegisterDesktop();
            } else {
              return RegisterMobile();
            }
          },
        ),
      ),
    );
  }
}