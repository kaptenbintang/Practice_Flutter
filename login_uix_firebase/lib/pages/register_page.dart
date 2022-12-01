// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:login_uix_firebase/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/registerPage';
  // final VoidCallback showLoginPage;
  const RegisterPage({super.key});

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
  // final _ageController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateofbirthController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final countryDial = "0";
  bool isEmail(String input) => EmailValidator.validate(input);
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    _dateofbirthController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    // _ageController.dispose();
    _phoneNumberController.dispose();
    _dateofbirthController.dispose();
    super.dispose();
  }

  Future signUp() async {
    String userUid;

    //authenticate user
    if (passwordConfirmed()) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

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
                // int.parse(_ageController.text.trim()),
                _phoneNumberController.text.trim(),
                _dateofbirthController.text.trim());
          }
        });
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
  }

  Future addUserDetails(String uid, String firstName, String lastName,
      String email, String phoneNumber, String dateofbirth) async {
    await db.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      // 'age': age,
      'phoneNumber': countryDial + phoneNumber,
      'dateofbirth': dateofbirth,
      'roles': 'user',
      'clientType': 'unassigned',
      'clientcode': getLastInitials(_lastNameController.text.toString()) +
          getInitials(_firstNameController.text.toString()) +
          '-' +
          generateRandomString(2),
      'imageUrl': '',
      'createdAt': DateTime.now().toString(),
      'markDeleted': false,
    });
  }

  String getInitials(String _firstNameController) =>
      _firstNameController.contains(' ')
          ? _firstNameController
              .trim()
              .split(RegExp(' +'))
              .reversed
              .map((s) => s[0])
              .take(2)
              .join()
              .toUpperCase()
          : _firstNameController
                  .trim()
                  .split(RegExp(' +'))
                  .map((s) => s[0])
                  .take(1)
                  .join()
                  .toUpperCase() +
              _firstNameController
                  .trim()
                  .split(RegExp(' +'))
                  .map((s) => s[1])
                  .take(1)
                  .join()
                  .toUpperCase();

  String getLastInitials(String _lastNameController) =>
      _lastNameController.isNotEmpty
          ? _lastNameController
              .trim()
              .split(RegExp(' +'))
              .map((s) => s[0])
              .take(1)
              .join()
              .toUpperCase()
          : '';

  // Define a reusable function
  String generateRandomString(int length) {
    final random = Random();
    const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
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
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
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
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
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
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: TextFormField(
                  //     keyboardType: TextInputType.number,
                  //     inputFormatters: <TextInputFormatter>[
                  //       FilteringTextInputFormatter.digitsOnly
                  //     ],
                  //     controller: _ageController,
                  //     decoration: InputDecoration(
                  //         labelText: "Ages",
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.blue),
                  //             borderRadius: BorderRadius.circular(12)),
                  //         // hintText: 'Age',
                  //         fillColor: Colors.grey[200],
                  //         filled: true),
                  //     validator: (value) {
                  //       if (value!.isEmpty || value.length > 3) {
                  //         return "Enter correct age";
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //   ),
                  // ),

                  SizedBox(height: 10),
                  //Date of Birth
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _dateofbirthController,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                        ),
                        // icon: Icon(
                        //   Icons.calendar_today,
                        //   color: Colors.blue,
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct date of birth";
                        } else {
                          return null;
                        }
                      },
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            _dateofbirthController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  
                  //Phone Number
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: IntlPhoneField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11)
                        ],
                        controller: _phoneNumberController,
                        showCountryFlag: true,
                        showDropdownIcon: true,
                        initialCountryCode: 'MY',
                        disableLengthCheck: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.toString().isEmpty) {
                            return "Enter correct phone number";
                          } else {
                            return null;
                          }
                        },
                      )),

                  SizedBox(height: 10),

                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email address",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.blue,
                          ),
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
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
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
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
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
                  //sign up button
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
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        },
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
