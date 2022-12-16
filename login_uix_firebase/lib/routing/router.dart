import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/pages/Events/events_page.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_page.dart';
import 'package:login_uix_firebase/pages/StartNow/start_now_page.dart';

import 'package:login_uix_firebase/pages/login/login_page.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_page.dart';
import 'package:login_uix_firebase/pages/manageClientType/manage_client_type_page.dart';
import 'package:login_uix_firebase/pages/managePractioners/manage_practioner_page.dart';
import 'package:login_uix_firebase/pages/manageRoles/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/manageServices/manage_services_page.dart';
import 'package:login_uix_firebase/pages/manageServicesCategory/manage_service_category_page.dart';
import 'package:login_uix_firebase/pages/manageStaff/manage_staff_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/registerPage/register_page.dart';
import 'package:login_uix_firebase/routing/logOutRoute.dart';

import 'package:login_uix_firebase/routing/routes.dart';

import '../main.dart';
import '../pages/manageAppointment/manage_appointment_page.dart';
import '../route.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingRoute:
      return _getPageRoute(LandingPage());
    case StartNowRoute:
      return _getPageRoute(StartNowPage());
    case EventsRoute:
      return _getPageRoute(EventPage());
    case LoginRoute:
      return _getPageRoute(LoginPage());
    case RegisterRoute:
      return _getPageRoute(RegisterPage());
    default:
      return _getPageRoute(LandingPage());
  }
}

Route<dynamic> generateRouteAdmin(RouteSettings settings) {
  switch (settings.name) {
    case ManageStaffRoute:
      return _getPageRoute(ManageStaffPage());
    case ManageClientRoute:
      return _getPageRoute(ManageClientPage());
    case ManageRolesRoute:
      return _getPageRoute(ManageRolesPage());
    case ManageClientTypeRoute:
      return _getPageRoute(ManageClientTypePage());
    case ManageServicesRoute:
      return _getPageRoute(ManageServicesPage());
    case ManageServicesCategoryRoute:
      return _getPageRoute(ManageServiceCategoryPage());
    case ManagePractionersRoute:
      return _getPageRoute(ManagePractionerPage());
    case AppointmentRoute:
      return _getPageRoute(ManageAppointmentPage());
    default:
      return _getPageRoute(ManageStaffPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
