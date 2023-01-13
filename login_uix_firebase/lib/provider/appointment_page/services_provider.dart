import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/services/services.dart';
import 'package:login_uix_firebase/provider/appointment_page/service_selected_notifier.dart';

//provide services data from firestore

final servicesProvider = StreamProvider.autoDispose<Iterable<Services>>(
  (ref) {
    final controller = StreamController<Iterable<Services>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.services,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final service = snapshots.docs.map(
          (doc) => Services(
            servicesId: doc.id,
            json: doc.data(),
          ),
        );
        controller.sink.add(service);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);

//provide selected service value
final selectedServiceProvider =
    StateNotifierProvider<ServicesNotifier, String>((ref) {
  return ServicesNotifier();
});
