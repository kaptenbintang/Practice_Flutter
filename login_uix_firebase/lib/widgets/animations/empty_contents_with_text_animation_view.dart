import 'package:flutter/material.dart';
import 'package:login_uix_firebase/widgets/animations/empty_contents_animation_view.dart';

import '../../helper/responsive.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

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
    return SizedBox(
      width: screenWidth / (width / 300),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth / (width / 8)),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
          SizedBox(
              width: screenWidth / (width / 300),
              height: screenWidth / (width / 300),
              child: EmptyContentsAnimationView()),
        ],
      ),
    );
  }
}
