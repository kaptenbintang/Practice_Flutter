import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/responsive.dart';

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
