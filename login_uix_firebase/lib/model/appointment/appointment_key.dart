import 'package:flutter/foundation.dart' show immutable;

// field name at Appoitment table firestore
@immutable
class AppointmentKey {
  static const clientId = 'clientId';
  static const practionerId = 'practionerId';
  static const clientComment = 'clientComment';
  static const clientEmail = 'clientEmail';
  static const clientNameorCode = 'clientNameorCode';
  static const clientphNumber = 'clientphNumber';
  static const createdAt = 'createdAt';
  static const date = 'date';
  static const time = 'time';
  static const location = 'location';
  static const practionerName = 'practionerName';
  static const services = 'services';
  static const statusAppointment = 'statusAppointment';

  const AppointmentKey._();
}
