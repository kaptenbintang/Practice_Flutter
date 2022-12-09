// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/manageStaff/manage_staff_mobile.dart';

import '../../helper/responsive.dart';
import 'manage_staff_desktop.dart';

class ManageStaffPage extends StatefulWidget {
  const ManageStaffPage({super.key});

  @override
  State<ManageStaffPage> createState() => _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageStaffDesktop();
    } else {
      return ManageStaffMobile();
    }
  }
}
