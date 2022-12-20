import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, dynamic> {
  final UserId userId;
  final String firstName;
  final String lastName;
  final String clientcode;
  final String? createdAt;
  final String? email;
  final String? phoneNumber;
  final String roles;
  final bool markDeleted;
  final String? clientType;
  final String? dateofbirth;

  UserInfoModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.clientcode,
    required this.createdAt,
    required this.email,
    required this.phoneNumber,
    required this.roles,
    required this.markDeleted,
    required this.clientType,
    required this.dateofbirth,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.firstName: firstName,
            FirebaseFieldName.lastName: lastName,
            FirebaseFieldName.clientcode: clientcode,
            FirebaseFieldName.createdAt: createdAt,
            FirebaseFieldName.email: email,
            FirebaseFieldName.phoneNumber: phoneNumber,
            FirebaseFieldName.roles: roles,
            FirebaseFieldName.markDeleted: markDeleted,
            FirebaseFieldName.clientType: clientType,
            FirebaseFieldName.dateofbirth: dateofbirth,
          },
        );

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          firstName: json[FirebaseFieldName.firstName] ?? '',
          lastName: json[FirebaseFieldName.lastName] ?? '',
          clientcode: json[FirebaseFieldName.clientcode] ?? '',
          createdAt: json[FirebaseFieldName.createdAt] ?? '',
          email: json[FirebaseFieldName.email],
          phoneNumber: json[FirebaseFieldName.phoneNumber] ?? '',
          roles: json[FirebaseFieldName.roles],
          markDeleted: json[FirebaseFieldName.markDeleted],
          clientType: json[FirebaseFieldName.clientType] ?? '',
          dateofbirth: json[FirebaseFieldName.dateofbirth] ?? '',
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          firstName,
          lastName,
          clientcode,
          createdAt,
          email,
          phoneNumber,
          roles,
          markDeleted,
          clientType,
          dateofbirth,
        ],
      );
}
