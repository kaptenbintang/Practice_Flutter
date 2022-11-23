import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_desktop.dart';
import 'package:login_uix_firebase/pages/LandingPage/landing_mobile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context) ||
        ResponsiveWidget.isMediumScreen(context)) {
      return LandingPageMobileWidget();
    } else {
      return LandingPageDesktopWidget();
    }
  }
}
