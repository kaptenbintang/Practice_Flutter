// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

import '../../helper/responsive.dart';

class PractionersThumbnailView extends StatelessWidget {
  final Practioner practioner;
  final VoidCallback onTapped;
  const PractionersThumbnailView({
    Key? key,
    required this.practioner,
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
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          boxShadow: [
            BoxShadow(
              blurRadius: screenWidth / (width / 12),
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth / (width / 20),
              vertical: screenWidth / (width / 8)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 0, 0, screenWidth / (width / 20)),
                child: Text(
                  practioner.firstName.toString() +
                      ' ' +
                      practioner.lastName.toString(),
                  style: FlutterFlowTheme.of(context).title3.override(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth / (width / 20)),
                  textAlign: TextAlign.center,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
                child: Image.asset(
                  'lib/images/doctor.png',
                  width: screenWidth / (width / 150),
                  height: screenWidth / (width / 150),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, screenWidth / (width / 8), 0, 0),
                child: Text(
                  "Speciality: " + practioner.mySpecialty.toString(),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic,
                      fontSize: ResponsiveWidget.isLargeScreen(context)
                          ? screenWidth / (width / 14)
                          : screenWidth / (width / 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
