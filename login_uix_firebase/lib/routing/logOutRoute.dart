import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/controllers/navigation_controller.dart';
import 'package:login_uix_firebase/pages/landing_layout.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';

import '../main.dart';
import '../route.dart';
import 'routes.dart';

dynamic logOutRoute(context, ref, child) async {
  await ref.read(authStateProvider.notifier).logOut().then((value) {
    // navigatorKey.currentState!.popUntil(ModalRoute.withName('/'));

    navigationController.navigationKey.currentState!
        .popUntil(ModalRoute.withName(sideMenuItems[3]));
    // navigationController.navigationKey.currentState!
    //     .popUntil(ModalRoute.withName(sideMenuItems[0]));
    // LandingLayout();

    // // navigationController.navigationKey.currentState!
    // //     .removeRoute(sideBarAdminItems[0]);
    // navigationController.navigateTo('/');
    // navigationController.navigateTo(sideMenuItems[0]);
    // menuController.changeActiveitemTo(sideMenuItems[0]);
  });
}
