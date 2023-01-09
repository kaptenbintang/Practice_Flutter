import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constant/firebase_collection_name.dart';
import '../../model/blackout_models/blackout.dart';
import '../../model/practioner_data.dart';
import '../../model/typedefs/is_loading.dart';

class BlackoutNotifier extends ChangeNotifier {
  final blackout = '';

  void changeBlackout(String selected) {
    blackout == selected;
    notifyListeners();
  }
}

// ignore: camel_case_types
// class blackoutUploadNotifier extends StateNotifier<IsLoading> {
//   blackoutUploadNotifier() : super(false);

//   set isLoading(bool value) => state = value;

//   Future<bool> upload({
//     required PractionerData practionerData,
//   }) async {
//     isLoading = true;

//     try {
//       final blackoutdPayload = blackoutPayload(
//         userId: practionerData.id.toString(),
//         blackout: practionerData.blackouts.toString(),
//       );
//       await FirebaseFirestore.instance
//           .collection(FirebaseCollectionName.blackout)
//           .add(
//             blackoutdPayload,
//           );
//       return true;
//     } catch (_) {
//       return false;
//     } finally {
//       isLoading = false;
//     }
//   }
// }
