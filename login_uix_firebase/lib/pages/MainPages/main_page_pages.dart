// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/responsive.dart';

import 'package:login_uix_firebase/pages/MainPages/main_page_desktop_riverpod.dart';
import 'package:login_uix_firebase/pages/MainPages/main_page_mobile.dart';

class MainPagesPage extends StatelessWidget {
  const MainPagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isLargeScreen(context)
        ? MainPageDesktopRiverpod()
        : MainPageMobile();
  }
}
