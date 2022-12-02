// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helper/responsive.dart';
import '../widgets/large_screen.dart';
import '../widgets/medium_screen.dart';
import '../widgets/side_menu.dart';
import '../widgets/small_screen.dart';
import '../widgets/top_nav.dart';

class LandingLayout extends StatelessWidget {
  LandingLayout({super.key});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, _scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        mediumScreen: MediumScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
