import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

const int largeScreenSizeWidth = 1366;
const int mediumScreenSizeWidth = 912;
const int smallScreenSizeWidth = 414;
const int customScreenSize = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget(
      {Key? key,
      required this.largeScreen,
      required this.mediumScreen,
      required this.smallScreen})
      : super(key: key);

  static bool isphoneScreen(BuildContext context) =>
      MediaQuery.of(context).size.width <= smallScreenSizeWidth;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width <= mediumScreenSizeWidth;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSizeWidth &&
      MediaQuery.of(context).size.width < largeScreenSizeWidth;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= largeScreenSizeWidth;

  static bool isCustomSize(BuildContext context) =>
      MediaQuery.of(context).size.width <= largeScreenSizeWidth &&
      MediaQuery.of(context).size.width >= smallScreenSizeWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double _width = constraints.maxWidth;
        if (_width >= largeScreenSizeWidth) {
          return largeScreen;
        } else if (_width < largeScreenSizeWidth &&
            _width > smallScreenSizeWidth) {
          return mediumScreen;
        } else {
          return smallScreen;
        }
      },
    );
  }
}
