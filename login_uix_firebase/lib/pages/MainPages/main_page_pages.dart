import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/pages/MainPages/main_page_desktop.dart';
import 'package:login_uix_firebase/pages/MainPages/main_page_desktop_riverpod.dart';
import 'package:login_uix_firebase/pages/MainPages/main_page_mobile.dart';

import '../../constant/controllers.dart';
import '../../widgets/custom_text.dart';

class MainPagesPage extends StatelessWidget {
  const MainPagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context) ||
            ResponsiveWidget.isMediumScreen(context)
        ? mainPageMobile()
        : MainPageDesktopRiverpod();
  }
}
