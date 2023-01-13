import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/appointment/appointment_updated.dart';
import 'package:login_uix_firebase/widgets/appointments/appointments_thumbnail_view.dart';

import '../../helper/responsive.dart';
import '../../provider/main_page/cancel_provider.dart';

class AppointmentsGridView extends StatelessWidget {
  final Iterable<Appointment> appointments;

  const AppointmentsGridView({
    Key? key,
    required this.appointments,
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
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveWidget.isLargeScreen(context) ? 3 : 1,
        mainAxisSpacing: ResponsiveWidget.isLargeScreen(context)
            ? screenWidth / (width / 300)
            : screenWidth / (width / 600),
        crossAxisSpacing: ResponsiveWidget.isLargeScreen(context)
            ? screenWidth / (width / 300)
            : screenWidth / (width / 600),
        childAspectRatio: 1.0,
      ),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments.elementAt(index);
        return AppointmentsThumbnailView(
          appointment: appointment,
          onTapped: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      Consumer(builder: (context, ref, child) {
                        return SizedBox(
                          height: screenWidth / (width / 20),
                          width: screenWidth / (width / 130),
                          child: MaterialButton(
                            color: Colors.red,
                            child: Text(
                              'Delete/Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Appointment appointmentData = Appointment({
                                'clientId':
                                    FirebaseAuth.instance.currentUser!.uid,
                                'statusAppointment':
                                    editStatusAppointment.toString(),
                              }, appointmentId: appointment.appointmentId);
                              await ref
                                  .read(editStatusAppointment.notifier)
                                  .editAppointmentCancel(
                                      appointmentData: appointmentData);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      }),
                      TextButton(
                        child: Text('Reschedule'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                    content: SizedBox(
                        width: screenWidth / (width / 250),
                        height: screenWidth / (width / 40),
                        child: Text("Edit Appointment")),
                  );
                });
          },
        );
      },
    );
  }
}
