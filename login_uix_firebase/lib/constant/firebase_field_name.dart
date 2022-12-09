import 'package:flutter/foundation.dart' show immutable;
import 'package:intl_phone_field/phone_number.dart';

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const createdAt = 'createdAt';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const email = 'email';
  static const dateofbirth = 'dateofbirth';
  static const clientcode = 'clientcode';
  static const clientType = 'clientType';
  static const phoneNumber = 'phoneNumber';
  static const roles = 'roles';
  static const markDeleted = 'markDeleted';
  const FirebaseFieldName._();
}
