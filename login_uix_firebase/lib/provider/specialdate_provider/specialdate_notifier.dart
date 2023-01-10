import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';
import 'package:login_uix_firebase/provider/specialdate_provider/specialdate_provider.dart';

import '../../model/practioner_data.dart';
import '../../model/practioner_models/practioner_key.dart';

class changeSpecialDate extends StateNotifier<IsLoading> {
  changeSpecialDate() : super(false);

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

class changeDescriptionDayoff extends StateNotifier<IsLoading> {
  changeDescriptionDayoff() : super(false);

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

class deleteSpecialDate extends StateNotifier<IsLoading> {
  deleteSpecialDate() : super(false);
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
