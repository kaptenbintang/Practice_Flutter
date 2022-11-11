import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/main.dart';
import 'package:login_uix_firebase/widgets/profile_text_input.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late bool buttonOpen;

  @override
  void initState() {
    emailController.text = user!.email.toString();
    // buttonOpen = false;
    super.initState();
  }

  void removeUser() {
    deleteUser();
  }

  Future deleteUser() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    try {
      await db.collection("users").doc(user?.uid).delete().onError(
            (error, stackTrace) => print('Something Wrong: $error'),
          );
      await user?.delete();
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Something Wrong: $e"),
            );
          });
    }
    Navigator.of(context).pop();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void authChenk() {
    authUser(
        emailController.text.toString(), passwordController.text.toString());
  }

  Future authUser(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user?.reauthenticateWithCredential(credential);
      setState(() {
        buttonOpen = true;
      });
      removeUser();

      return;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileTextInput(
            textEditingController: emailController,
            hintTextString: "Enter Email",
            maxLength: 30,
            labelText: "Email",
            obscure: false,
            readonly: false,
          ),
          SizedBox(height: 20),
          ProfileTextInput(
            textEditingController: passwordController,
            hintTextString: "Enter Password",
            maxLength: 30,
            labelText: "Password",
            obscure: true,
            readonly: false,
          ),
          // ElevatedButton(
          //   onPressed: authChenk,
          //   child: const Text("Re Login"),
          // ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: authChenk,
            child: const Text("Delete"),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
