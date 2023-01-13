import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

//update status start time practioners in firestore

class ChangeStatusStartTime extends StateNotifier<IsLoading> {
  ChangeStatusStartTime() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editStartTime({
    required String schedule,
    required int index,
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
            'schedules.$index.startTime': schedule,
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

//update status end time practioners in firestore

class ChangeStatusEndTime extends StateNotifier<IsLoading> {
  ChangeStatusEndTime() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editEndTime({
    required String schedule,
    required int index,
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
            'schedules.$index.endTime': schedule,
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
