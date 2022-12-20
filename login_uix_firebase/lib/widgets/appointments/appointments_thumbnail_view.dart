import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

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
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).lineColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                appointment.practionerName.toString(),
                style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/images/doctor.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                appointment.services.toString(),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
              Text(
                "Booking Date: " + appointment.dateandtime.toString(),
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
