import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/delete_account_page.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';

import '../main.dart';
import 'change_pw_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    auth.currentUser?.updateEmail(email);
    await db.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    }).onError((error, stackTrace) => print("Error writing document: $error"));
  }

  Future editUserData() async {
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
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Your personal details has been updated"),
              );
            });
        print("aku");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(future: db.collection("users").doc(uid).get(),builder: (context, DocumentSnapshot snapshot){ final data = snapshot.data() as Map<String, dynamic>;};);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('signed in as: ' + user.email!),
          SizedBox(height: 20),
          ProfileTextInput(
            textEditingController: nameController,
            hintTextString: 'Enter Name',
            maxLength: 20,
            labelText: 'Name',
            obscure: false,
          ),
          SizedBox(height: 20),
          ProfileTextInput(
            textEditingController: lastsNameController,
            hintTextString: 'Enter Last Name',
            maxLength: 40,
            labelText: 'Last Name',
            obscure: false,
          ),
          SizedBox(height: 20),
          ProfileTextInput(
            textEditingController: emailController,
            hintTextString: 'Enter Email',
            maxLength: 20,
            labelText: 'Email',
            obscure: false,
          ),
          SizedBox(height: 20),
          ProfileTextInput(
            textEditingController: ageController,
            hintTextString: 'Enter Age',
            maxLength: 3,
            labelText: 'Age',
            obscure: false,
          ),
          SizedBox(height: 20),
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
            child: const Text('Update'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeleteAccount(),
                ),
              );
            },
            // async {
            //   uid = auth.currentUser?.uid;

            //   bool step1 = true;
            //   bool step2 = false;
            //   bool step3 = false;
            //   while (true) {
            //     if (step1) {
            //       //delete user info in the database
            //       await db.collection('users').doc(uid).delete();
            //       step1 = false;
            //       step2 = true;
            //     }

            //     if (step2) {
            //       //delete user
            //       user.delete();
            //       step2 = false;
            //       step3 = true;
            //     }

            //     if (step3) {
            //       await FirebaseAuth.instance.signOut();
            //       step3 = false;
            //     }

            //     if (!step1 && !step2 && !step3) {
            //       break;
            //     }
            //   }
            // },
            child: const Text('Delete'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return changePasswordPage();
                    },
                  ),
                );
              },
              child: const Text('Change Password')),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              },
              child: const Text('Sign Out'))
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

class DatabaseService {}
