import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/location_models/location.dart';
import 'package:login_uix_firebase/model/services/services.dart';
import 'package:login_uix_firebase/provider/appointment_page/location_notifier.dart';

final locationProvider = StreamProvider.autoDispose<Iterable<Location>>(
  (ref) {
    final controller = StreamController<Iterable<Location>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.location,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final location = snapshots.docs.map(
          (doc) => Location(
            locationId: doc.id,
            json: doc.data(),
          ),
        );
        controller.sink.add(location);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);

final locationSelectedProvider =
    StateNotifierProvider<LocationNotifier, String>((ref) {
  return LocationNotifier();
});
