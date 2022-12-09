// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/widgets/large_adminDashboard.dart';
import 'package:login_uix_firebase/widgets/medium_adminDashboard.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin.dart';
import 'package:login_uix_firebase/widgets/small_adminDashboard.dart';

import '../widgets/top_nav.dart';

class AdminDashboardLayout extends StatelessWidget {
  AdminDashboardLayout({super.key});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      // appBar: ResponsiveWidget.isSmallScreen(context)
      //     ? topNavigationBar(context, _scaffoldKey)
      //     : null,
      appBar: (ResponsiveWidget.isSmallScreen(context))
          ? topNavigationBar(context, _scaffoldKey)
          : null,
      drawer: Container(
        width: 200,
        child: Drawer(
          elevation: 16,
          child: SideBarAdmin(),
        ),
      ),
      body: SafeArea(
        child: ResponsiveWidget(
          largeScreen: LargeAdminDashboard(),
          mediumScreen: MediumAdminDashboard(),
          smallScreen: SmallAdminDashboard(),
        ),
      ),
    );
  }
}
