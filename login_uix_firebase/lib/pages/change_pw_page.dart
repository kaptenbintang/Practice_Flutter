// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/auth/authenticator.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';
import 'package:login_uix_firebase/pages/login_page.dart';

import '../main.dart';

class changePasswordPage extends StatefulWidget {
  static const routeName = '/changePwPage';
  const changePasswordPage({super.key});

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {
  var newPassword = "";
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final currentUser = FirebaseAuth.instance.currentUser;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  changePassword() async {
    if (passwordConfirmed()) {
      try {
        await currentUser!.updatePassword(newPassword);
        FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    "Your password has been changed & Please login again!"),
              );
            });
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   backgroundColor: Colors.black26,
        //   content: Text("Your password has been changed & login again!"),
        // ));
      } catch (error) {}
    }
  }

  bool passwordConfirmed() {
    if (newPasswordController.text.trim() ==
        newConfirmPasswordController.text.trim()) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Your Password is not same, Please try again!"),
            );
          });
      return false;
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    newConfirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[200],
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Create new pasword',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your new password must be different \n"
                      "from previous used passwords",
                      style: TextStyle(color: Color(0xFF8a929f), fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[600]),
                          ),
                        ),
                        TextFormField(
                          // maxLines: 1,
                          // maxLength: 6,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            hintText: "Enter your new password",
                            hintStyle: TextStyle(color: Color(0xFF6f6f6f)),
                            counterText: '',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Color(0xFFf3f5f6),
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          controller: newPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        FlutterPwValidator(
                            width: 350,
                            height: 110,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            onSuccess: () {
                              print("submitted");
                            },
                            controller: newPasswordController),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[600]),
                          ),
                        ),
                        TextFormField(
                          // maxLines: 1,
                          // maxLength: 3,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            hintText: "Confirm your password",
                            hintStyle: TextStyle(color: Color(0xFF6f6f6f)),
                            counterText: '',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Color(0xFFf3f5f6),
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          controller: newConfirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              newPassword = newPasswordController.text;
                            });
                            changePassword();
                          }
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 55,
                          width: 400,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue),
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "Change Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
