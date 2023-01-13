import 'package:flutter/material.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/constant/controllers.dart';

import 'routes.dart';

dynamic logOutRoute(context, ref, child) async {
  await ref.read(authStateProvider.notifier).logOut().then((value) {
    // navigatorKey.currentState!.popUntil(ModalRoute.withName('/'));

    navigationController.navigationKey.currentState!
        .popUntil(ModalRoute.withName(sideMenuItems[3]));
  });
}
