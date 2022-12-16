// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_desktop.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_desktop_riverpod.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_mobile.dart';
import 'package:login_uix_firebase/pages/viewProfilePage/view_profile_mobile_riverpod.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return ProfilePageMobileWidgetRiverpod();
    } else {
      return ProfileRiverpodPage2();
    }
  }
}
