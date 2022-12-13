import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      // DocumentSnapshot<Map<String, dynamic>>
      // QuerySnapshot<Map<String, dynamic>>
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

final userDetailProvider1 = StreamProvider.autoDispose<Map>(
  (ref) {
    // final userProvider = ref.watch(currentCityProvider);
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // final auth = FirebaseAuth.instance;

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
        // controller.stream.asyncMap(
        //   (event) => event = posts as Iterable<Map>,
        // );
        controller.sink.add(data as Map);
      },
    );
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;

    // final userId = FirebaseAuth.instance.currentUser!.uid;
    // return ref.watch(apiProvider).currentUsers(userId);
  },
);
