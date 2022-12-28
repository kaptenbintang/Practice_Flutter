import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/local_navigator.dart';
import 'package:login_uix_firebase/widgets/side_menu.dart';

import '../helper/responsive.dart';

class MediumScreen extends StatelessWidget {
  const MediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return Row(
      children: [
        Expanded(child: SideMenu()),
        Expanded(
            flex: 5,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth / (width / 16)),
              child: localNavigator(),
            ))
      ],
    );
  }
}
