import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/widgets/appointments/appointments_thumbnail_view.dart';

import '../../model/appointment_data.dart';
import '../../provider/main_page/cancel_provider.dart';

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
            print(appointment.statusAppointment);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      Consumer(builder: (context, ref, child) {
                        return Container(
                          height: 30,
                          child: MaterialButton(
                            color: Colors.red,
                            child: Text(
                              'Delete/Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              AppointmentData appointmentData = AppointmentData(
                                clientId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                statusAppointment:
                                    editStatusAppointment.toString(),
                              );
                              await ref
                                  .read(editStatusAppointment.notifier)
                                  .editAppointmentCancel(
                                      appointmentData: appointmentData);
                              // .then((value) => ref
                              //     .refresh(cancelAppointmentStatus.future)); ini klo mau di refresh lg tampilan statusnya tp gadipake karena udh ada yang ngecheck perubahan status ongoing appointment
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
                    content: Container(child: Text("Edit Appointment")),
                  );
                });
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
