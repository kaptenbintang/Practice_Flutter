import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/appointment/appointment_updated.dart';
// import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

import '../../helper/responsive.dart';

class AppointmentsThumbnailView extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTapped;
  const AppointmentsThumbnailView({
    Key? key,
    required this.appointment,
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTapped,
        child: Container(
          width: screenWidth / (width / 300),
          height: screenWidth / (width / 300),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                appointment.practionerName.toString(),
                style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth / (width / 20),
                    ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth / (width / 8)),
                child: Image.asset(
                  'lib/images/doctor.png',
                  width: screenWidth / (width / 150),
                  height: screenWidth / (width / 150),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                appointment.services.toString(),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth / (width / 14),
                    ),
              ),
              Text(
                "Booking Date: " + appointment.date.toString(),
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: screenWidth / (width / 14),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
