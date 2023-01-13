// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../helper/responsive.dart';
import '../widgets/large_screen.dart';
import '../widgets/medium_screen.dart';
import '../widgets/side_menu.dart';
import '../widgets/small_screen.dart';
import '../widgets/top_nav.dart';

class LandingLayout extends StatelessWidget {
  LandingLayout({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, _scaffoldKey),
      drawer: SizedBox(
        width: Dimensions.width100 * 2,
        child: Drawer(
          child: SideMenu(),
        ),
      ),
      body: SafeArea(
        child: ResponsiveWidget(
          largeScreen: LargeScreen(),
          mediumScreen: MediumScreen(),
          smallScreen: SmallScreen(),
        ),
      ),
    );
  }
}
