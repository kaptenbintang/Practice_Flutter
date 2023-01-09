// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
// import 'package:login_uix_firebase/provider/blackout_provider/blackout_notifier.dart';

// import '../../model/blackout_models/blackout.dart';
// import '../../model/typedefs/is_loading.dart';

// final blackoutProvider = StreamProvider.autoDispose<Iterable<Blackout>>(
//   (ref) {
//     final controller = StreamController<Iterable<Blackout>>();

//     final sub = FirebaseFirestore.instance
//         .collection(
//           FirebaseCollectionName.blackout,
//         )
//         .snapshots()
//         .listen(
//       (snapshots) {
//         final blackoutDay = snapshots.docs.map(
//           (doc) => Blackout(
//             blackoutId: doc.id,
//             json: doc.data(),
//           ),
//         );
//         controller.sink.add(blackoutDay);
//       },
//     );

//     ref.onDispose(() {
//       sub.cancel();
//       controller.close();
//     });

//     return controller.stream;
//   },
// );

// final selectedBlackoutProvider =
//     ChangeNotifierProvider<BlackoutNotifier>((ref) {
//   return BlackoutNotifier();
// });


// // final blackoutUploaderProvider =
// //     StateNotifierProvider<blackoutUploadNotifier, IsLoading>(
// //   (ref) => blackoutUploadNotifier(),
// // );