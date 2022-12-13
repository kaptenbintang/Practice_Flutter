import 'package:flutter/cupertino.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/routing/router.dart';
import 'package:login_uix_firebase/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: LandingRoute,
      onGenerateRoute: generateRoute,
    );

Navigator adminDashboardNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: ManageStaffRoute,
      onGenerateRoute: generateRouteAdmin,
    );
