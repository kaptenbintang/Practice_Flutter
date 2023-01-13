import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';

// Object model to store userinfo that later uploaded to firestore

@immutable
class UserInfoPayload extends MapView<String, dynamic> {
  UserInfoPayload({
    required UserId userId,
    required String? firstName,
    required String? lastName,
    required String? clientcode,
    required String? createdAt,
    required String? email,
    required String? phoneNumber,
    required String roles,
    required bool markDeleted,
    required String? clientType,
    required String? dateofbirth,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.firstName: firstName ?? '',
            FirebaseFieldName.lastName: lastName ?? '',
            FirebaseFieldName.clientcode: clientcode ?? '',
            FirebaseFieldName.createdAt: createdAt ?? '',
            FirebaseFieldName.email: email ?? '',
            FirebaseFieldName.phoneNumber: phoneNumber ?? '',
            FirebaseFieldName.roles: roles,
            FirebaseFieldName.markDeleted: markDeleted,
            FirebaseFieldName.clientType: clientType ?? 'user',
            FirebaseFieldName.dateofbirth: dateofbirth ?? '',
          },
        );
}
