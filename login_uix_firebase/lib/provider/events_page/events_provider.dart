import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';

import '../../model/events/events.dart';

//provide all practioners data from firestore

final allEventsProvider = StreamProvider.autoDispose<Iterable<Events>>(
  (ref) {
    final controller = StreamController<Iterable<Events>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.events,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final event = snapshots.docs.map(
          (doc) => Events(
            EventsId: doc.id,
            json: doc.data(),
          ),
        );
        controller.sink.add(event);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
