import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';

class changeStatusStartTime extends StateNotifier<IsLoading> {
  changeStatusStartTime() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editStartTime({
    required Map schedule,
  }) async {
    try {
      isLoading = true;
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.practioners,
          )
          .where(FirebaseFieldName.schedules)
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.schedules: schedule,
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
