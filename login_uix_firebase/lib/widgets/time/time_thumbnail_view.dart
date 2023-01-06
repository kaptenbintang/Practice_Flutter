import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

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
    return InkWell(
      onTap: onTapped,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 50),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Text(serviceTime),
        ),
      ),
    );
  }
}
