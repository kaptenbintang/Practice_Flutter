import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/auth/controller_page.dart';
import 'package:login_uix_firebase/pages/Events/events_page.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_page.dart';
import 'package:login_uix_firebase/pages/StartNow/start_now_page.dart';

import 'package:login_uix_firebase/pages/login/login_page.dart';

import 'package:login_uix_firebase/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingRoute:
      return _getPageRoute(LandingPage());
    case StartNowRoute:
      return _getPageRoute(StartNowPage());
    case EventsRoute:
      return _getPageRoute(EventPage());
    default:
      return _getPageRoute(LoginPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}