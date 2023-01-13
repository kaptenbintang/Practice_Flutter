import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';

class Authenticator {
  const Authenticator();

  // getters

  // Get bool value if user have a value or null
  bool get isAlreadyLoggedIn => userId != null;
  // Get current user Id from FirebaseAuth
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  // Get current user name from FirebaseAuth
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  // Get current user email from FirebaseAuth
  String? get email => FirebaseAuth.instance.currentUser?.email;

// Function for logout current user
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

// Function for login with email and password inputed from login page UI on FirebaseAuth
  Future<AuthResult> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("No user found for that email."),
              );
            });

        return AuthResult.failure;
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Wrong password provided for that user."),
              );
            });

        return AuthResult.failure;
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
        return AuthResult.failure;
      }
    }
  }

  // Function for create new account on FirebaseAuth using email and password inputed from user in register page UI

  Future<AuthResult> createWithEmailandPassword(
      String email, String password, String name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return AuthResult.failure;

        case 'invalid-email':
          return AuthResult.failure;

        case 'weak-password':
          return AuthResult.failure;
      }
      return AuthResult.failure;
    }
  }
}
