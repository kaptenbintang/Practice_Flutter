import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/manageServices/manage_services_desktop.dart';
import 'package:login_uix_firebase/pages/manageServices/manage_services_mobile.dart';
import '../../helper/responsive.dart';

class ManageServicesPage extends StatefulWidget {
  const ManageServicesPage({super.key});

  @override
  State<ManageServicesPage> createState() => _ManageServicesPageState();
}

class _ManageServicesPageState extends State<ManageServicesPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageServicesDesktop();
    } else {
      return ManageServicesMobile();
    }
  }
}
