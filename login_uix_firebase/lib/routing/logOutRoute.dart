import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/controllers/navigation_controller.dart';

import '../main.dart';
import '../route.dart';

Future<dynamic> logOutRoute() async {
  FirebaseAuth.instance.signOut();
  navigatorKey.currentState!.popUntil(ModalRoute.withName('/'));
  NavigationController.instance.navigationKey.currentState!
      .popUntil(ModalRoute.withName('/'));
}
