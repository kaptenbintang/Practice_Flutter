import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';

class changeSpecialDate extends StateNotifier<IsLoading> {
  changeSpecialDate() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editstartDayoff({
    required String dayoffs,
    required int index,
  }) async {
    try {
      isLoading = true;
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.practioners,
          )
          .where(FirebaseFieldName.dayoff)
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            'dayoff.$index.dateDayoff': dayoffs,
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
