// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';

import '../../constant/controllers.dart';
import '../../route.dart';
import '../../routing/routes.dart';
import '../forgot_pw_page.dart';

class RegisterDesktop extends StatefulWidget {
  const RegisterDesktop({super.key});

  @override
  State<RegisterDesktop> createState() => _RegisterDesktopState();
}

class _RegisterDesktopState extends State<RegisterDesktop> {
  bool _isChecked = false;
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateofbirthController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final countryDial = "0";

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

  String getLastInitials(String _lastNameController) {
    return _lastNameController.isNotEmpty
        ? _lastNameController
            .trim()
            .split(RegExp(' +'))
            .map((s) => s[0])
            .take(1)
            .join()
            .toUpperCase()
        : '';
  }

  String getInitials(String _firstNameController) {
    return _firstNameController.contains(' ')
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
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
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

  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = 1920;
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey),
            child: Image.asset(
              'lib/images/mountain.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          //<-- Expanded widget
          child: Container(
            constraints: BoxConstraints(maxWidth: _width / (maxWidth / 21)),
            padding: EdgeInsets.symmetric(horizontal: _width / (maxWidth / 50)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome',
                    style: GoogleFonts.inter(
                      fontSize: _width / (maxWidth / 17),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: _width / (maxWidth / 8)),
                  Text(
                    'Register new account',
                    style: GoogleFonts.inter(
                      fontSize: _width / (maxWidth / 23),
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: _width / (maxWidth / 35)),

//first name
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: _width / (maxWidth / 20),
                      ),
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: _width / (maxWidth / 8)),
                          labelStyle:
                              TextStyle(fontSize: _width / (maxWidth / 20)),
                          labelText: "First Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: _width / (maxWidth / 24),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),

                  // last name textfield
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: _width / (maxWidth / 20),
                      ),
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: _width / (maxWidth / 8)),
                          labelStyle:
                              TextStyle(fontSize: _width / (maxWidth / 20)),
                          labelText: "Last Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: _width / (maxWidth / 24),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),

                  // ages textfield
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: _width / (maxWidth /16.0)),
                  //   child: TextFormField(
                  //  style: TextStyle(
                  //   fontSize: _width/(maxWidth/20),
                  //height: _width/(maxWidth/100),
                  //  ),
                  //     keyboardType: TextInputType.number,
                  //     inputFormatters: <TextInputFormatter>[
                  //       FilteringTextInputFormatter.digitsOnly
                  //     ],
                  //     controller: _ageController,
                  //     decoration: InputDecoration(
                  // isDense: true,
                  // contentPadding: EdgeInsets.symmetric(vertical: _width/(maxWidth/1)),
                  //labelStyle: TextStyle(fontSize: _width/(maxWidth/20)),
                  //labelText: "Ages",
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white),
                  //             borderRadius: BorderRadius.circular(_width / (maxWidth /12))),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.blue),
                  //             borderRadius: BorderRadius.circular(_width / (maxWidth /12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),
                  //Date of Birth
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: _width / (maxWidth / 20),
                      ),
                      controller: _dateofbirthController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: _width / (maxWidth / 8)),
                        labelStyle:
                            TextStyle(fontSize: _width / (maxWidth / 20)),
                        labelText: "Date of Birth",
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.blue,
                          size: _width / (maxWidth / 24),
                        ),
                        // icon: Icon(
                        //   Icons.calendar_today,
                        //   color: Colors.blue,
                        //size: _width/(maxWidth/24),
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                                _width / (maxWidth / 12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                _width / (maxWidth / 12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),

                  //Phone Number
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _width / (maxWidth / 16.0)),
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
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: _width / (maxWidth / 8)),
                          labelStyle:
                              TextStyle(fontSize: _width / (maxWidth / 20)),
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),

                  // email textfield
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: _width / (maxWidth / 20),
                      ),
                      controller: _emailController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: _width / (maxWidth / 8)),
                          labelStyle:
                              TextStyle(fontSize: _width / (maxWidth / 20)),
                          labelText: "Email address",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.blue,
                            size: _width / (maxWidth / 24),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12))),
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

                  SizedBox(height: _width / (maxWidth / 10)),

                  //password textfield
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            fontSize: _width / (maxWidth / 20),
                          ),
                          controller: _passwordController,
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: _width / (maxWidth / 8)),
                            labelStyle:
                                TextStyle(fontSize: _width / (maxWidth / 20)),
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                              size: _width / (maxWidth / 24),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(
                                    _width / (maxWidth / 12))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(
                                    _width / (maxWidth / 12))),
                            // hintText: 'Password',
                            fillColor: Colors.grey[200],
                            filled: true,
                            suffix: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(_isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility),
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
                  SizedBox(height: _width / (maxWidth / 10)),
                  // confirm password textfield
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width / (maxWidth / 16.0)),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: _width / (maxWidth / 20),
                      ),
                      controller: _confirmpasswordController,
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: _width / (maxWidth / 8)),
                        labelStyle:
                            TextStyle(fontSize: _width / (maxWidth / 20)),
                        labelText: "Confirm Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                          size: _width / (maxWidth / 24),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                                _width / (maxWidth / 12))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                _width / (maxWidth / 12))),
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
                  SizedBox(height: _width / (maxWidth / 30)),
                  //Register Button
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // signUp();
                        // final result =
                        //     await Authenticator().createWithEmailandPassword(
                        //   _emailController.text,
                        //   _passwordController.text,
                        // );
                        // print(result);
                        return;
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: Text(
                      'Register now',
                      style: GoogleFonts.inter(
                        fontSize: _width / (maxWidth / 15),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: _width / (maxWidth / 25)),
                  //already a member? login now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigationController.navigateTo(sideMenuItems[3]);
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
      ],
    );
  }

  void onChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }
}

class HiddenPass extends StateNotifier<bool?> {
  HiddenPass() : super(true);
  void change() => state = state == false ? true : false;
}

final hiddenPassProvider = StateNotifierProvider<HiddenPass, bool?>((ref) {
  return HiddenPass();
});

class RegisterDeskStop2 extends ConsumerWidget {
  const RegisterDeskStop2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmpasswordController = TextEditingController();
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _phoneNumberController = TextEditingController();
    final _dateofbirthController = TextEditingController();
    final countryDial = "0";
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = 1920;

    final _formKey = GlobalKey<FormState>();
    bool isEmail(String input) => EmailValidator.validate(input);

    String getLastInitials(String _lastNameController) {
      return _lastNameController.isNotEmpty
          ? _lastNameController
              .trim()
              .split(RegExp(' +'))
              .map((s) => s[0])
              .take(1)
              .join()
              .toUpperCase()
          : '';
    }

    String getInitials(String _firstNameController) {
      return _firstNameController.contains(' ')
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
    }

    String generateRandomString(int length) {
      final random = Random();
      const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
      final randomString = List.generate(length,
              (index) => availableChars[random.nextInt(availableChars.length)])
          .join();

      return randomString;
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: _width / (maxWidth / 100)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                child: Image.asset(
                  'lib/images/mountain.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: _width / (maxWidth / 21)),
                padding:
                    EdgeInsets.symmetric(horizontal: _width / (maxWidth / 50)),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome',
                          style: GoogleFonts.inter(
                            fontSize: _width / (maxWidth / 17),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: _width / (maxWidth / 8)),
                        Text(
                          'Register new account',
                          style: GoogleFonts.inter(
                            fontSize: _width / (maxWidth / 23),
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: _width / (maxWidth / 35)),

                        //first name
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: _width / (maxWidth / 20),
                            ),
                            controller: _firstNameController,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: _width / (maxWidth / 8)),
                                labelStyle: TextStyle(
                                    fontSize: _width / (maxWidth / 20)),
                                labelText: "First Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: _width / (maxWidth / 24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
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

                        SizedBox(height: _width / (maxWidth / 10)),

                        // last name textfield
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: _width / (maxWidth / 20),
                            ),
                            controller: _lastNameController,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: _width / (maxWidth / 8)),
                                labelStyle: TextStyle(
                                    fontSize: _width / (maxWidth / 20)),
                                labelText: "Last Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: _width / (maxWidth / 24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
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

                        SizedBox(height: _width / (maxWidth / 10)),

                        // ages textfield
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: _width / (maxWidth /16.0)),
                        //   child: TextFormField(
                        //  style: TextStyle(
                        //    fontSize: _width/(maxWidth/20),
                        //height: _width/(maxWidth/100),
                        //  ),
                        //     keyboardType: TextInputType.number,
                        //     inputFormatters: <TextInputFormatter>[
                        //       FilteringTextInputFormatter.digitsOnly
                        //     ],
                        //     controller: _ageController,
                        //     decoration: InputDecoration(
                        //  isDense: true,
                        // contentPadding: EdgeInsets.symmetric(vertical: _width/(maxWidth/1)),
                        //labelStyle: TextStyle(fontSize: _width/(maxWidth/20)),
                        //labelText: "Ages",
                        //         enabledBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.white),
                        //             borderRadius: BorderRadius.circular(_width / (maxWidth /12))),
                        //         focusedBorder: OutlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.blue),
                        //             borderRadius: BorderRadius.circular(_width / (maxWidth /12))),
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

                        SizedBox(height: _width / (maxWidth / 10)),
                        //Date of Birth
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: _width / (maxWidth / 20),
                            ),
                            controller: _dateofbirthController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: _width / (maxWidth / 8)),
                              labelStyle:
                                  TextStyle(fontSize: _width / (maxWidth / 20)),
                              labelText: "Date of Birth",
                              prefixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                                size: _width / (maxWidth / 24),
                              ),
                              // icon: Icon(
                              //   Icons.calendar_today,
                              //   color: Colors.blue,
                              //size: _width/(maxWidth/24),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      _width / (maxWidth / 12))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      _width / (maxWidth / 12))),
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

                                // setState(() {
                                _dateofbirthController.text =
                                    formattedDate; //set output date to TextField value.
                                // });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ),

                        SizedBox(height: _width / (maxWidth / 10)),

                        //Phone Number
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: _width / (maxWidth / 16.0)),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: _width / (maxWidth / 8)),
                                labelStyle: TextStyle(
                                    fontSize: _width / (maxWidth / 20)),
                                labelText: "Phone Number",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
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

                        SizedBox(height: _width / (maxWidth / 10)),

                        // email textfield
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: _width / (maxWidth / 20),
                            ),
                            controller: _emailController,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: _width / (maxWidth / 8)),
                                labelStyle: TextStyle(
                                    fontSize: _width / (maxWidth / 20)),
                                labelText: "Email address",
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.blue,
                                  size: _width / (maxWidth / 24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(
                                        _width / (maxWidth / 12))),
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

                        SizedBox(height: _width / (maxWidth / 10)),

                        //password textfield
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: Column(
                            children: [
                              Consumer(
                                builder: (BuildContext context, WidgetRef ref,
                                    Widget? child) {
                                  final hidden = ref.watch(hiddenPassProvider)!;
                                  return TextFormField(
                                    style: TextStyle(
                                      fontSize: _width / (maxWidth / 20),
                                    ),
                                    controller: _passwordController,
                                    obscureText: hidden,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: _width / (maxWidth / 8)),
                                      labelStyle: TextStyle(
                                          fontSize: _width / (maxWidth / 20)),
                                      labelText: "Password",
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.blue,
                                        size: _width / (maxWidth / 24),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              _width / (maxWidth / 12))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                          borderRadius: BorderRadius.circular(
                                              _width / (maxWidth / 12))),
                                      // hintText: 'Password',
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      suffix: InkWell(
                                        onTap: ref
                                            .read(hiddenPassProvider.notifier)
                                            .change,
                                        child: Icon(hidden
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
                                  );
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
                        SizedBox(height: _width / (maxWidth / 10)),
                        // confirm password textfield
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _width / (maxWidth / 16.0)),
                          child: Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              final hidden = ref.watch(hiddenPassProvider)!;
                              return TextFormField(
                                style: TextStyle(
                                  fontSize: _width / (maxWidth / 20),
                                ),
                                controller: _confirmpasswordController,
                                obscureText: hidden,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: _width / (maxWidth / 8)),
                                  labelStyle: TextStyle(
                                      fontSize: _width / (maxWidth / 20)),
                                  labelText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.blue,
                                    size: _width / (maxWidth / 24),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          _width / (maxWidth / 12))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(
                                          _width / (maxWidth / 12))),
                                  // hintText: 'Confirm Password',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  suffix: InkWell(
                                    onTap: ref
                                        .read(hiddenPassProvider.notifier)
                                        .change,
                                    child: Icon(hidden
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
                              );
                            },
                          ),
                        ),
                        SizedBox(height: _width / (maxWidth / 30)),
                        //Register Button
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // signUp();
                              // final result =
                              //     await Authenticator().createWithEmailandPassword(
                              //   _emailController.text,
                              //   _passwordController.text,
                              // );
                              // print(result);
                              // return;
                              String clientCode = getLastInitials(
                                      _lastNameController.text.toString()) +
                                  getInitials(
                                      _firstNameController.text.toString()) +
                                  '-' +
                                  generateRandomString(2);

                              await ref
                                  .read(authStateProvider.notifier)
                                  .createdWithEmailPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    clientCode,
                                    DateTime.now().toString(),
                                    countryDial + _phoneNumberController.text,
                                    'user',
                                    false,
                                    'unassigned',
                                    _dateofbirthController.text,
                                  );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                          ),
                          child: Text(
                            'Register now',
                            style: GoogleFonts.inter(
                              fontSize: _width / (maxWidth / 15),
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: _width / (maxWidth / 25)),
                        //already a member? login now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already a member?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _width / (maxWidth / 15),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigationController
                                    .navigateTo(sideMenuItems[3]);
                              },
                              child: Text(
                                " Login now!",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _width / (maxWidth / 15),
                                ),
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
          ],
        ),
      ),
    );
  }
}
