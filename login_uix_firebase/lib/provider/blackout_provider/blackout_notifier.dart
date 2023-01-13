import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import '../../model/practioner_data.dart';

//update status day name in firestore

class ChangeStatusDayNameNotifier extends StateNotifier<IsLoading> {
  ChangeStatusDayNameNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editDayName({
    required PractionerData practionerData,
    required String index,
  }) async {
    try {
      isLoading = true;
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.practioners,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: practionerData.id,
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.blackout: index,
            // FirebaseFieldName.blackout: "1",
          },
        );
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
