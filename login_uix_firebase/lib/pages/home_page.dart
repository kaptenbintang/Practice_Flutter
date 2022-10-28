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
  @override
  Widget build(BuildContext context) {
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('hello ${nameController.text}'),
                  );
                },
              );
            },
            child: const Text('Sumbit'),
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
    super.dispose();
  }
}
