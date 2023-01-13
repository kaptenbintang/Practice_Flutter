import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/StartNow/start_now_desktop.dart';
import 'package:login_uix_firebase/pages/StartNow/start_now_mobile.dart';

import '../../helper/responsive.dart';

class StartNowPage extends StatefulWidget {
  const StartNowPage({super.key});

  @override
  State<StartNowPage> createState() => _StartNowPageState();
}

class _StartNowPageState extends State<StartNowPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return StartNowDesktop();
    } else {
      return StartNowMobile();
    }
  }
}
