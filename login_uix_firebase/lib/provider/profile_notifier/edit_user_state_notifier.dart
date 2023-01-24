import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';

//update current user data in firestore

class EditUserNotifier extends StateNotifier<IsLoading> {
  EditUserNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editUser({
    required UserData userData,
  }) async {
    try {
      isLoading = true;

      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userData.id.toString(),
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.firstName: userData.firstName,
            FirebaseFieldName.lastName: userData.lastName,
            FirebaseFieldName.phoneNumber: userData.phoneNumber,
            FirebaseFieldName.dateofbirth: userData.doBirth,
            FirebaseFieldName.profilePic: userData.profilePic,
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
