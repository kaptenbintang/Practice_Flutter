import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
// import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/appointment/appointment_key.dart';
import 'package:login_uix_firebase/model/appointment/appointment_updated.dart';

final userAppointmentProvider2 =
    StreamProvider.autoDispose<Iterable<Appointment>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<Appointment>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.appointment,
        )
        // .orderBy(
        //   FirebaseFieldName.createdAt,
        //   descending: false,
        // )
        .where(
          AppointmentKey.clientId,
          isEqualTo: userId,
        )
        .where("statusAppointment", isNotEqualTo: "ongoing")
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final appointments = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) =>
                  // Appointment(
                  //   appointmentId: doc.id,
                  //   json: doc.data(),
                  // ),
                  Appointment(doc.data(), appointmentId: doc.id),
            );
        controller.sink.add(appointments);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
