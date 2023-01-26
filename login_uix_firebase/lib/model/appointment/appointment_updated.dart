import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/appointment/appointment_key.dart';

// object model for storaging appointment data from firestore
@immutable
class Appointment extends Equatable {
  final String appointmentId;
  final String practionerId;
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

  Appointment(Map<String, dynamic> json, {required this.appointmentId})
      : practionerId = json[AppointmentKey.practionerId],
        clientId = json[AppointmentKey.clientId],
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

  @override
  List<Object?> get props => [
        appointmentId,
        practionerId,
        clientId,
        clientComment,
        clientEmail,
        clientNameorCode,
        clientphNumber,
        createdAt,
        date,
        time,
        location,
        practionerName,
        services,
        statusAppointment,
      ];
}
