import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/pages/detail_practioner_page.dart';
import 'package:login_uix_firebase/widgets/appointments/appointments_thumbnail_view.dart';
import 'package:login_uix_firebase/widgets/practioners/practioners_thumbnail_view.dart';

class AppointmentsGridView extends StatelessWidget {
  final Iterable<Appointment> appointments;

  const AppointmentsGridView({
    Key? key,
    required this.appointments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments.elementAt(index);
        return AppointmentsThumbnailView(
          appointment: appointment,
          onTapped: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailPagePractioner(
            //       practioner: appointment,
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }
}
