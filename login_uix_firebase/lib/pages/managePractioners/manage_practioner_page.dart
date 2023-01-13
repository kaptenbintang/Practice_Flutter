import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/managePractioners/manage_practioner_desktop.dart';
import 'package:login_uix_firebase/pages/managePractioners/manage_practioner_mobile.dart';

import '../../helper/responsive.dart';

class ManagePractionerPage extends StatefulWidget {
  const ManagePractionerPage({super.key});

  @override
  State<ManagePractionerPage> createState() => _ManagePractionerPageState();
}

class _ManagePractionerPageState extends State<ManagePractionerPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManagePractionerDesktop();
    } else {
      return ManagePractionerMobile();
    }
  }
}
