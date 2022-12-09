import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/user_data.dart';

final currentCityProvider = StateProvider<UserData?>(
  (ref) {
    return null;
  },
);

class GetDataFromFirestore {
  const GetDataFromFirestore();

  Future<Map<String, dynamic>?> currentUsers(uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return snapshot.data()!;
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
  (ref) async {
    // final userProvider = ref.watch(currentCityProvider);

    // final auth = FirebaseAuth.instance;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    return ref.watch(apiProvider).currentUsers(userId);

    // final controller = StreamController<Map>();

    // final sub = FirebaseFirestore.instance
    //     .collection(
    //       'users',
    //     )
    //     .doc(userId)
    //     .get();

    // if (userProvider == null) {
    //   return currentUsers(userId);
    // } else {
    //   return null;
    // }

    // final result = sub.map((event) => UserData.fromDocumentSnapshot(event));
    // final result1 = sub.map((event) => controller.sink.add(event.data()!));

    //     .listen(
    //   (event) {
    //     final data = UserData.fromDocumentSnapshot(event);
    //     controller.sink.add(data);
    //   },
    // );
    // final result = await sub;

    // ref.onDispose(() {
    //   // sub.cancel();
    //   // sub.drain();
    //   // controller.close();
    // });

    // return result.data()!;
  },
);
