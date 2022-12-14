import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentData {
  final String? id;
  final String? practionerName;
  final String? services;
  final String? dateandtime;
  final String? location;
  final String? clientNameorCode;
  final String? clientEmail;
  final String? clientphNumber;
  final String? clientComment;
  final String? statusAppointment;

  AppointmentData({
    this.id,
    this.practionerName,
    this.services,
    this.dateandtime,
    this.location,
    this.clientNameorCode,
    this.clientEmail,
    this.clientphNumber,
    this.clientComment,
    this.statusAppointment,
  });

  Map<String, dynamic> toMap() {
    return {
      "practionerName": practionerName,
      "services": services,
      "dateandtime": dateandtime,
      "location": location,
      "clientNameorCode": clientNameorCode,
      "clientEmail": clientEmail,
      "clientphNumber": clientphNumber,
      "clientComment": clientComment,
      "statusAppointment": statusAppointment,
    };
  }

  AppointmentData.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        practionerName = doc.data()!["practionerName"],
        services = doc.data()!["services"],
        dateandtime = doc.data()!["dateandtime"],
        location = doc.data()!["location"],
        clientNameorCode = doc.data()!["clientNameorCode"],
        clientEmail = doc.data()!["clientEmail"],
        clientphNumber = doc.data()!["clientphNumber"],
        clientComment = doc.data()!["clientComment"],
        statusAppointment = doc.data()!["statusAppointment"];
}
