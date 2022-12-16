// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_dekstop.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_mobile.dart';

import 'manage_appointment_desktop.dart';
import 'manage_appointment_mobile.dart';

class ManageAppointmentPage extends StatefulWidget {
  const ManageAppointmentPage({super.key});

  @override
  State<ManageAppointmentPage> createState() => _ManageAppointmentPageState();
}

class _ManageAppointmentPageState extends State<ManageAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageAppointmentDesktop();
    } else {
      return ManageAppointmentMobile();
    }
  }
}
