import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

import '../../helper/responsive.dart';

class TimesThumbnailView extends StatelessWidget {
  final String serviceTime;
  final VoidCallback onTapped;
  const TimesThumbnailView({
    Key? key,
    required this.serviceTime,
    required this.onTapped,
  }) : super(key: key);

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
    return InkWell(
      onTap: onTapped,
      child: Padding(
        padding: EdgeInsets.all(screenWidth / (width / 4)),
        child: Container(
          // constraints: const BoxConstraints(maxHeight: 50),

          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lineColor,
            boxShadow: [
              BoxShadow(
                blurRadius: screenWidth / (width / 12),
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(screenWidth / (width / 10)),
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Text(
              serviceTime,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: ResponsiveWidget.isLargeScreen(context)
                      ? screenWidth / (width / 18)
                      : screenWidth / (width / 14)),
            ),
          ),
        ),
      ),
    );
  }
}
