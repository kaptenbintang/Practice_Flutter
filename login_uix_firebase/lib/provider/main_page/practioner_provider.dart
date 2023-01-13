import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';

//provide all practioners data from firestore

final allPractionersProvider = StreamProvider.autoDispose<Iterable<Practioner>>(
  (ref) {
    final controller = StreamController<Iterable<Practioner>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.practioners,
        )
        .orderBy(
          FirebaseFieldName.firstName,
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final practioner = snapshots.docs.map(
          (doc) => Practioner(
            userId: doc.id,
            json: doc.data(),
          ),
        );
        controller.sink.add(practioner);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
