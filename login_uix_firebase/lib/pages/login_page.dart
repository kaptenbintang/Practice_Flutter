// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';

import 'package:login_uix_firebase/pages/register_page.dart';

import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';
  // final VoidCallback showRegisterPage;
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future signIn() async {
//loading circle
    FirebaseAuth.instance.signOut();

    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => ControllerPage());
    } on FirebaseAuthException catch (e) {
      print(e);
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
    Navigator.of(context).pop();
  }

  //create validation login

  // String? get _errorEmailText {
  //   final emailErrorText = _emailController.value.text;
  //   if (emailErrorText.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   if (emailErrorText.length < 4) {
  //     return 'Too short';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }

  // String? get _errorPasswordText {
  //   final passwordErrorText = _passwordController.value.text;
  //   if (passwordErrorText.isEmpty) {
  //     return 'Can\'t be empty';
  //   }
  //   if (passwordErrorText.length < 4) {
  //     return 'Too short';
  //   }
  //   // return null if the text is valid
  //   return null;
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.android,
                    size: 100,
                  ),

                  SizedBox(height: 75),

                  // Hello again!
                  Text(
                    'Hello again!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 54,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 50),
                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      // onChanged: (text) => setState(() => _text),
                      decoration: InputDecoration(
                          labelText: "Email address",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.blue,
                          ),
                          // errorText: _errorEmailText,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12)),
                          // hintText: 'Email',
                          fillColor: Colors.grey[200],
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty || !isEmail(value)) {
                          return "Enter correct email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _passwordController,
                      // onChanged: (text) => setState(() => _text),
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                        // errorText: _errorPasswordText,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        // hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(_isHidden
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return "Enter correct password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          signIn();
                          return;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //not a member? registernow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterPage.routeName);
                        },
                        child: Text(
                          " Register now!",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
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
