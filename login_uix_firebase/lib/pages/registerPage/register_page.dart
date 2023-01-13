import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/registerPage/register_desktop.dart';
import 'package:login_uix_firebase/pages/registerPage/register_mobile_riverpod.dart';

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
        backgroundColor: Color.fromARGB(255, 250, 246, 246),
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return RegisterDeskStop2();
            } else {
              return RegisterMobileRiverpod();
            }
          },
        ),
      ),
    );
  }
}
