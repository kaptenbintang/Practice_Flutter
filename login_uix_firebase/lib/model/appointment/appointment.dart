import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/model/appointment/appointment_key.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner_key.dart';

@immutable
class Appointment {
  final String appointmentId;
  final String clientId;
  final String clientComment;
  final String clientEmail;
  final String clientNameorCode;
  final String clientphNumber;
  final String createdAt;
  final String date;
  final String time;
  final String location;
  final String practionerName;
  final String services;
  final String statusAppointment;

  Appointment({
    required this.appointmentId,
    required Map<String, dynamic> json,
  })  : clientId = json[AppointmentKey.clientId],
        clientComment = json[AppointmentKey.clientComment],
        clientEmail = json[AppointmentKey.clientEmail],
        clientNameorCode = json[AppointmentKey.clientNameorCode],
        clientphNumber = json[AppointmentKey.clientphNumber],
        createdAt = json[AppointmentKey.createdAt],
        date = json[AppointmentKey.date],
        time = json[AppointmentKey.time],
        location = json[AppointmentKey.location],
        practionerName = json[AppointmentKey.practionerName],
        services = json[AppointmentKey.services],
        statusAppointment = json[AppointmentKey.statusAppointment];

  // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}
