import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';

import '../../model/practioner_models/practioner.dart';
import '../../model/practioner_models/practioner_key.dart';

final timeScheduleProvider = StreamProvider.autoDispose<Iterable<Practioner>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<Practioner>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.practioners,
        )
        // .orderBy(
        //   FirebaseFieldName.createdAt,
        //   descending: false,
        // )
        .where(
          PractionerKey.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final schedules = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Practioner(
                practionerId: doc.id,
                json: doc.data(),
              ),
            );
        controller.sink.add(schedules);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
