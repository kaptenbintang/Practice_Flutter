// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isEmail(String input) => EmailValidator.validate(input);
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signUp() async {
    String userUid;

    //authenticate user
    if (passwordConfirmed()) {
      try {
        //create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        //add user details
        auth.authStateChanges().listen((User? user) {
          if (user == null) {
            SnackBar(
              content: const Text('There is no User Login'),
            );
          } else {
            userUid = user.uid;
            addUserDetails(
              userUid,
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _emailController.text.trim(),
              int.parse(_ageController.text.trim()),
            );
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }
    }
  }

  Future addUserDetails(String uid, String firstName, String lastName,
      String email, int age) async {
    await db.collection('users').doc(uid).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: prefer_const_constructors

                  // Hello again!
                  Text(
                    'Hello there!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 54,
                    ),
                  ),
                  SizedBox(height: 10),
                  // ignore: prefer_const_constructors
                  Text(
                    'Register below with Your details',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 50),

                  // first name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12)),
                          // hintText: 'First Name',
                          fillColor: Colors.grey[200],
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                .hasMatch(value)) {
                          return "Enter correct name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // last name textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          labelText: "Last Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12)),
                          // hintText: 'Last Name',
                          fillColor: Colors.grey[200],
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                .hasMatch(value)) {
                          return "Enter correct name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // ages textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: _ageController,
                      decoration: InputDecoration(
                          labelText: "Ages",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12)),
                          // hintText: 'Age',
                          fillColor: Colors.grey[200],
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty || value.length > 3) {
                          return "Enter correct age";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email address",
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            labelText: "Password",
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
                            if (value!.isEmpty) {
                              return "Enter correct password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        FlutterPwValidator(
                            width: 400,
                            height: 110,
                            minLength: 6,
                            uppercaseCharCount: 1,
                            numericCharCount: 1,
                            specialCharCount: 1,
                            onSuccess: () {
                              print("submitted");
                            },
                            controller: _passwordController)
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // confirm password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _confirmpasswordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        // hintText: 'Confirm Password',
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
                        if (value!.isEmpty) {
                          return "Enter correct password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  //sign in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          signUp();
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
                          'Sign Up',
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
                        "I\'am a member!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          " Login now!",
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
