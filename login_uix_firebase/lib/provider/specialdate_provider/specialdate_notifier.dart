import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import '../../model/practioner_data.dart';
import '../../model/practioner_models/practioner_key.dart';

//update special date practioner value at firestore

class ChangeSpecialDate extends StateNotifier<IsLoading> {
  ChangeSpecialDate() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editstartDayoff({
    required PractionerData practionerData,
    required String dayoffs,
    required int index,
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

//update DescriptionDayoff  practioner value at firestore

class ChangeDescriptionDayoff extends StateNotifier<IsLoading> {
  ChangeDescriptionDayoff() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editDescription({
    required PractionerData practionerData,
    required String descriptiong,
    required int index,
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
            'dayoff.$index.description': descriptiong,
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

//update deleteSpecialDate  practioner value at firestore

class DeleteSpecialDate extends StateNotifier<IsLoading> {
  DeleteSpecialDate() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> deleteDayoff(
      {required int selectedIndex,
      required String userID,
      required Map listDay}) async {
    final removepls = listDay.remove([selectedIndex]);
    try {
      isLoading = true;
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.practioners,
          )
          .where(FirebaseFieldName.dayoff)
          .where(
            PractionerKey.userId,
            isEqualTo: userID,
          )
          .limit(1)
          .get();
      /* Get list from firestore */

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          'dayoff': removepls,
        });
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
