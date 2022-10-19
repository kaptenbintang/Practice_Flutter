import 'package:flutter/material.dart';
import 'package:multipage_screen_navigation/main.dart';
import 'package:multipage_screen_navigation/mainpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text("Login"),
        onPressed: (() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return MainPage();
          }));
        }),
      )),
    );
  }
}
