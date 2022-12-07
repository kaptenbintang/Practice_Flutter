import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentData {
  final String? id;
  final String? practionerName;
  final String? services;
  final String? dateandtime;
  final String? location;

  AppointmentData({
    this.id,
    this.practionerName,
    this.services,
    this.dateandtime,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      "practionerName": practionerName,
      "services": services,
      "dateandtime": dateandtime,
      "location": location,
    };
  }

  AppointmentData.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        practionerName = doc.data()!["practionerName"],
        services = doc.data()!["services"],
        dateandtime = doc.data()!["dateandtime"],
        location = doc.data()!["location"];
}
