import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final lastsNameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  var uid;
  var fName, lName, age;

  Future<void> getDataFromDb() async {
    if (auth.currentUser != null) {
      uid = auth.currentUser?.uid;

      // var a = await db.collection("users").doc(uid).get();
      // return a.data();
      // then((DocumentSnapshot doc) {
      // final data = doc.data() as Map<String, dynamic>;
      // String fName = data['first name'];
      // print(uid + 'UID');
      // return data;
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return AlertDialog(
      //       content: Text('halo: $fName'),
      //     );
      //   },
      // );
      await db.collection("users").doc(uid).get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        fName = data["firstName"];
        lName = data["lastName"];
        age = data["age"];
      });
      setState(() {
        emailController.text = user.email.toString();
        nameController.text = fName;
        lastsNameController.text = lName;
        ageController.text = age.toString();
      });
    }
    ;
  }

  @override
  void initState() {
    getDataFromDb();
    super.initState();
  }

  Future editUserDetails(String uid, String firstName, String lastName,
      String email, int age) async {
    print(email);
    await db.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    });
  }

  Future editUserData() async {
    //authenticate user

    //create user
    await auth.currentUser?.updateEmail(emailController.toString());

    //add user details
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        SnackBar(
          content: const Text('There is no User Login'),
        );
      } else {
        uid = auth.currentUser?.uid;
        editUserDetails(
          uid,
          nameController.text.trim(),
          lastsNameController.text.trim(),
          emailController.text.trim(),
          int.parse(ageController.text.trim()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(future: db.collection("users").doc(uid).get(),builder: (context, DocumentSnapshot snapshot){ final data = snapshot.data() as Map<String, dynamic>;};);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('signed in as: ' + user.email!),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.blue,
            child: Text('Sign Out'),
          ),
          ProfileTextInput(
            textEditingController: nameController,
            hintTextString: 'Enter Name',
            maxLength: 20,
            labelText: 'Name',
          ),
          ProfileTextInput(
              textEditingController: lastsNameController,
              hintTextString: 'Enter Last Name',
              maxLength: 40,
              labelText: 'Last Name'),
          ProfileTextInput(
              textEditingController: emailController,
              hintTextString: 'Enter Email',
              maxLength: 20,
              labelText: 'Email'),
          ProfileTextInput(
              textEditingController: ageController,
              hintTextString: 'Enter Age',
              maxLength: 3,
              labelText: 'Age'),
          ElevatedButton(
            onPressed: () {
              editUserData();
              print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
              // uid = auth.currentUser?.uid;
              // db
              //     .collection("users")
              //     .doc(uid)
              //     .get()
              //     .then((DocumentSnapshot doc) {
              //   final data = doc.data() as Map<String, dynamic>;
              //   fName = data['firstName'];
              // }).onError((error, stackTrace) => null);

              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       content: Text('halo: $fName'),
              //     );
              //   },
              // );
            },
            child: const Text('Submit'),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    lastsNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
