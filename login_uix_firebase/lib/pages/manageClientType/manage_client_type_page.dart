import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/manageClientType/manage_client_type_desktop.dart';

import '../../helper/responsive.dart';
import 'manage_client_type_mobile.dart';

class ManageClientTypePage extends StatefulWidget {
  const ManageClientTypePage({super.key});

  @override
  State<ManageClientTypePage> createState() => _ManageClientTypePageState();
}

class _ManageClientTypePageState extends State<ManageClientTypePage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageClientTypeDesktop();
    } else {
      return ManageClientTypeMobile();
    }
  }
}
