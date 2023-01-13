import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';

//provide current user data from firebase

class GetDataFromFirestore {
  const GetDataFromFirestore();

  Future<Map<String, dynamic>?> currentUsers(uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('uid', isEqualTo: uid.toString())
          .limit(1)
          .get();
      final result = snapshot.docs[0];
      return result.data();
    } on FirebaseException catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

final apiProvider =
    Provider<GetDataFromFirestore>((ref) => GetDataFromFirestore());

const unknownWeatherEmoji = '??';

final userDetailProvider = FutureProvider.autoDispose<Map?>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    return ref.watch(apiProvider).currentUsers(userId);
  },
);

final userDetailProvider1 = StreamProvider.autoDispose<Map>(
  (ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final controller = StreamController<Map>();

    final sub = FirebaseFirestore.instance
        .collection(
          'users',
        )
        .where('uid', isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshots) {
        final data = snapshots.docs;

        controller.sink.add(data as Map);
      },
    );
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
