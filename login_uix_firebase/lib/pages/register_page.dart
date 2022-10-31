// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
    //authenticate user
    if (passwordConfirmed()) {
      //create user
      await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      // final User? user = auth.currentUser;
      // final uid = user!.uid;
      // final FirebaseAuth user2 = await auth.currentUser();
      String userUid;

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

      //add user details

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
                  'Register below with your details',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),

                // first name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'First Name',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                SizedBox(height: 10),

                // last name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Last Name',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                SizedBox(height: 10),

                // ages textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Age',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                SizedBox(height: 10),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Email',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                SizedBox(height: 10),

                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),
                SizedBox(height: 10),
                // confirm password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _confirmpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Confirm Password',
                        fillColor: Colors.grey[200],
                        filled: true),
                  ),
                ),

                SizedBox(height: 10),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: signUp,
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
                        " Login now",
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
    );
  }
}
