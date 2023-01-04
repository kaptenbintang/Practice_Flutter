import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/appointment/appointment_key.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';

@immutable
class AppointmentPayload extends MapView<String, dynamic> {
  AppointmentPayload({
    required UserId userId,
    required String practionerId,
    required String practionerName,
    required String services,
    required String date,
    required String time,
    required String location,
    required String clientNameorCode,
    required String clientEmail,
    required String clientphNumber,
    required String clientComment,
    required String statusAppointment,
    required String createdAt,
  }) : super(
          {
            AppointmentKey.clientId: userId,
            AppointmentKey.practionerId: practionerId,
            AppointmentKey.practionerName: practionerName,
            AppointmentKey.services: services,
            AppointmentKey.date: date,
            AppointmentKey.time: time,
            AppointmentKey.location: location,
            AppointmentKey.clientNameorCode: clientNameorCode,
            AppointmentKey.clientEmail: clientEmail,
            AppointmentKey.clientphNumber: clientphNumber,
            AppointmentKey.clientComment: clientComment,
            AppointmentKey.statusAppointment: statusAppointment,
            AppointmentKey.createdAt: createdAt,
          },
        );
}
