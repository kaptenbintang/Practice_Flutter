// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow.dart';

import '../helper/responsive.dart';
import '../main.dart';
import 'check_email_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgatPwPage';
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Util.routeToWidget(context, CheckEmailView());
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: (!ResponsiveWidget.isLargeScreen(context))
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
                elevation: 0,
              )
            : null,
        body: Container(
          width: double.maxFinite,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: ResponsiveWidget.isLargeScreen(context)
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Forgot Password?',
                      style: FlutterFlowTheme.of(context).title1),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter the email associated with your account and we\'ll send an email with instructions to reset your password',
                    style: FlutterFlowTheme.of(context).bodyText2,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Email',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your email address",
                        hintStyle: FlutterFlowTheme.of(context).subtitle2,
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
                      ),
                      textAlign: ResponsiveWidget.isLargeScreen(context)
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: passwordReset,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        height: 30,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: FlutterFlowTheme.of(context).secondaryColor),
                        padding: EdgeInsets.all(4),
                        child: Center(
                          child: Text(
                            "Send a Instructions!",
                            textAlign: TextAlign.center,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
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
    );
  }
}
