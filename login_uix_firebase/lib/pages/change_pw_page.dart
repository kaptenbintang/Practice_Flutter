// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/pages/profile_page.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../helper/responsive.dart';
import '../main.dart';

class changePWPage extends StatefulWidget {
  static const routeName = '/changePwPage';
  const changePWPage({super.key});

  @override
  State<changePWPage> createState() => _changePWPageState();
}

class _changePWPageState extends State<changePWPage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return SafeArea(
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          actions: const [],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: screenWidth / (width / 30),
              borderWidth: 1,
              buttonSize: screenWidth / (width / 30),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
                size: screenWidth / (width / 20),
              ),
              onPressed: () {
                print('IconButton pressed ...');
                Navigator.pop(context);
              },
            ),
          ),

          title: Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
            child: Text(
              'Change Password',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: screenWidth / (width / 30),
                  ),
            ),
          ),

          // actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Create new pasword',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your new password must be different \n"
                    "from previous used passwords",
                    style: TextStyle(color: Color(0xFF8a929f), fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
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
                    ),
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
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
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePassword();
                      }
                    },
                    text: 'Change Password',
                    options: FFButtonOptions(
                      height: screenWidth / (width / 40),
                      color: Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF101213),
                                fontSize: screenWidth / (width / 14),
                                fontWeight: FontWeight.normal,
                              ),
                      elevation: 1,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
