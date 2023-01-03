import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';
import 'package:login_uix_firebase/pages/landing_layout.dart';

class Authenticator {
  const Authenticator();

  // getters

  bool get isAlreadyLoggedIn => userId != null;
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
  }

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
              return AlertDialog(
                content: Text("No user found for that email."),
              );
            });
        print('No user found for that email.');
        return AuthResult.failure;
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Wrong password provided for that user."),
              );
            });
        print('Wrong password provided for that user.');
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
      final email = e.email;

      switch (e.code) {
        case 'email-already-in-use':
          print('$email invalid email');
          return AuthResult.failure;

        case 'invalid-email':
          print('$email this email not exist');
          return AuthResult.failure;

        case 'weak-password':
          print('Password is wrong for this $email');
          return AuthResult.failure;
      }
      return AuthResult.failure;
    }
  }

  // Future<AuthResult> loginWithFacebook() async {
  //   final loginResult = await FacebookAuth.instance.login();
  //   final token = loginResult.accessToken?.token;
  //   if (token == null) {
  //     return AuthResult.aborted;
  //   }
  //   final oauthCredentials = FacebookAuthProvider.credential(token);

  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(
  //       oauthCredentials,
  //     );
  //     return AuthResult.success;
  //   } on FirebaseAuthException catch (e) {
  //     final email = e.email;
  //     final credential = e.credential;
  //     if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
  //         email != null &&
  //         credential != null) {
  //       final providers =
  //           await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //       if (providers.contains(Constants.googleCom)) {
  //         await loginWithGoogle();
  //         FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
  //       }
  //       return AuthResult.success;
  //     }
  //     return AuthResult.failure;
  //   }
  // }

  // Future<AuthResult> loginWithGoogle() async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: [
  //       Constants.emailScope,
  //     ],
  //   );
  //   final signInAccount = await googleSignIn.signIn();
  //   if (signInAccount == null) {
  //     return AuthResult.aborted;
  //   }

  //   final googleAuth = await signInAccount.authentication;
  //   final oauthCredentials = GoogleAuthProvider.credential(
  //     idToken: googleAuth.idToken,
  //     accessToken: googleAuth.accessToken,
  //   );
  //   try {
  //     await FirebaseAuth.instance.signInWithCredential(
  //       oauthCredentials,
  //     );
  //     return AuthResult.success;
  //   } catch (e) {
  //     return AuthResult.failure;
  //   }
  // }
}
