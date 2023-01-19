// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:login_uix_firebase/pages/Events/events_page.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_page.dart';
import 'package:login_uix_firebase/pages/StartNow/start_now_page.dart';
import 'package:login_uix_firebase/pages/add_user_page.dart';
import 'package:login_uix_firebase/pages/forgot_pw_page.dart';

import 'package:login_uix_firebase/pages/login/login_page.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_page.dart';
import 'package:login_uix_firebase/pages/manageClientType/manage_client_type_page.dart';
import 'package:login_uix_firebase/pages/manageEvents/manage_event_desktop.dart';
import 'package:login_uix_firebase/pages/manageEvents/manage_event_page.dart';
import 'package:login_uix_firebase/pages/managePractioners/manage_practioner_page.dart';
import 'package:login_uix_firebase/pages/manageRoles/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/manageServices/manage_services_page.dart';
import 'package:login_uix_firebase/pages/manageServicesCategory/manage_service_category_page.dart';
import 'package:login_uix_firebase/pages/manageStaff/manage_staff_page.dart';

import 'package:login_uix_firebase/pages/registerPage/register_page.dart';

import 'package:login_uix_firebase/routing/routes.dart';

import '../pages/manageAppointment/manage_appointment_page.dart';

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
    case ForgotPassworRoute:
      return _getPageRoute(ForgotPasswordPage());
    default:
      return _getPageRoute(LandingPage());
  }
}

Route<dynamic> generateRouteAdmin(RouteSettings settings) {
  switch (settings.name) {
    case ManageEventsRoute:
      return _getPageRoute(ManageEventPage());
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
    case AddNewUserRoute:
      return _getPageRoute(AddUserPage());
    default:
      return _getPageRoute(ManageEventPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
