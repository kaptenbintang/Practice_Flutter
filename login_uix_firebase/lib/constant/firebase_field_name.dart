import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const createdAt = 'createdAt';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const email = 'email';
  static const clientEmail = 'clientEmail';
  static const dateofbirth = 'dateofbirth';
  static const clientcode = 'clientcode';
  static const clientType = 'clientType';
  static const phoneNumber = 'phoneNumber';
  static const roles = 'roles';
  static const markDeleted = 'markDeleted';
  static const statusAppointment = 'statusAppointment';
  static const schedules = 'schedules';
  static const dayoff = 'dayoff';
  static const blackout = 'blackout';
  static const profilePic = 'profilePic';

  const FirebaseFieldName._();
}
