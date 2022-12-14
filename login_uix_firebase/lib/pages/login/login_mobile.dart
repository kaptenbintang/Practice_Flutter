// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/pages/registerPage/register_page.dart';
import 'package:login_uix_firebase/route.dart';

import '../../auth/controller_page.dart';
import '../../constant/controllers.dart';
import '../../routing/routes.dart';
import '../forgot_pw_page.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  bool _isChecked = false;
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

//   Future signIn() async {
// //loading circle
//     FirebaseAuth.instance.signOut();
//     // showDialog(
//     //     context: context,
//     //     builder: (context) {
//     //       return Center(child: CircularProgressIndicator());
//     //     });

//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: _emailController.text.trim(),
//               password: _passwordController.text.trim())
//           .then((value) => ControllerPage());
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       await showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text(e.message.toString()),
//             );
//           });
//     }
//     // Navigator.of(context).pop();
//   }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height30),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome back',
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.font17,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: Dimensions.height08),
                      Text(
                        'Login to your account',
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.font23,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                          height: Dimensions.height30 + Dimensions.height05),

                      //email textfield
                      TextFormField(
                        controller: _emailController,
                        // onChanged: (text) => setState(() => _text),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: Dimensions.height10,
                                bottom: Dimensions.height10),
                            labelText: "Email address",
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.blue,
                              size: Dimensions.iconSize24,
                            ),
                            // errorText: _errorEmailText,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius12)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius12)),
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
                      SizedBox(height: Dimensions.height20),
                      //password textfield
                      TextFormField(
                        controller: _passwordController,
                        // onChanged: (text) => setState(() => _text),
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                            size: Dimensions.iconSize24,
                          ),
                          // errorText: _errorPasswordText,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius12)),
                          // hintText: 'Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: Dimensions.width08,
                                  top: Dimensions.height20 / 10),
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: Dimensions.iconSize24,
                              ),
                            ),
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
                      SizedBox(
                          height: Dimensions.height20 + Dimensions.height05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: Dimensions.height24,
                                width: Dimensions.width24,
                                child: Checkbox(
                                    value: _isChecked, onChanged: onChanged),
                              ),
                              SizedBox(width: Dimensions.width08),
                              Text(
                                'Remember me',
                                style: GoogleFonts.inter(
                                  fontSize: Dimensions.font14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              width:
                                  Dimensions.width20 + Dimensions.width10 / 2),
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
                              'Forgot password?',
                              style: GoogleFonts.inter(
                                fontSize: Dimensions.font14,
                                color: const Color.fromARGB(255, 0, 84, 152),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height30),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // signIn();
                          }
                          return;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height20,
                            horizontal: Dimensions.width10,
                          ),
                        ),
                        child: Text(
                          'Login now',
                          style: GoogleFonts.inter(
                            fontSize: Dimensions.font15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                          height: Dimensions.height20 + Dimensions.height05),
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
                              navigationController.navigateTo(sideMenuItems[4]);
                            },
                            child: Text(
                              " Register now!",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }
}
