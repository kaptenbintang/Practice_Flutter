import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';
import 'package:login_uix_firebase/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String firstName,
    required String lastName,
    required String clientcode,
    required String? createdAt,
    required String? email,
    required String? phoneNumber,
    required String roles,
    required bool markDeleted,
    required String? clientType,
    required String? dateofbirth,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's profile, save the new data instead
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.firstName: firstName,
          FirebaseFieldName.lastName: lastName,
          FirebaseFieldName.clientcode: clientcode,
          FirebaseFieldName.email: email,
          FirebaseFieldName.markDeleted: markDeleted,
          FirebaseFieldName.createdAt: createdAt ?? '',
          FirebaseFieldName.phoneNumber: phoneNumber ?? '',
          FirebaseFieldName.roles: roles,
          FirebaseFieldName.clientType: clientType ?? '',
          FirebaseFieldName.dateofbirth: dateofbirth ?? '',
        });
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        clientcode: clientcode,
        roles: roles,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        dateofbirth: dateofbirth,
        clientType: clientType,
        createdAt: createdAt,
        markDeleted: markDeleted,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .doc(userId)
          .set(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}
