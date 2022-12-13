// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_dekstop.dart';
import 'package:login_uix_firebase/pages/manageClient/manage_client_mobile.dart';

class ManageClientPage extends StatefulWidget {
  const ManageClientPage({super.key});

  @override
  State<ManageClientPage> createState() => _ManageClientPageState();
}

class _ManageClientPageState extends State<ManageClientPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageClientDesktop();
    } else {
      return ManageClientMobile();
    }
  }
}
