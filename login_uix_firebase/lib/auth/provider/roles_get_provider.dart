import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';

final getRolesPrivProvider = StreamProvider.autoDispose<Map>((ref) {
  final userData = ref
      .watch(
        userDetailProvider,
      )
      .value;

  final controller = StreamController<Map>();

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.roles,
      )
      .where(
        'rolesName',
        isEqualTo: userData?['roles'],
      )
      .limit(1)
      .snapshots()
      .listen((event) {
    final one = event.docs[0];
    controller.sink.add(one.data());
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
