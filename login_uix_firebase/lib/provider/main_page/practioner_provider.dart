import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<PractionerData>>(
  (ref) {
    final controller = StreamController<Iterable<PractionerData>>();

    final sub = FirebaseFirestore.instance
        .collection(
          'practioners',
        )
        .orderBy(
          'firstName',
          descending: true,
        )
        .snapshots()
        .listen(
      (snapshots) {
        final posts = snapshots.docs.map(
          (doc) => PractionerData(
            firstName: doc['firstName'],
            lastName: doc['lastName'],
            languages: doc['languages'],
            myApproach: doc['myApproach'],
            myBackground: doc['myBackground'],
            myQualifications: doc['myQualifications'],
            myRoles: doc['myRoles'],
            mySpecialty: doc['mySpecialty'],
            titleMain: doc['titleMain'],
            id: doc['id'],
          ),
        );
        controller.sink.add(posts);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
