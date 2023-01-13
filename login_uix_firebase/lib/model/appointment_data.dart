import 'package:cloud_firestore/cloud_firestore.dart';
// object model for storaging appointment data from firestore

class AppointmentData {
  final String? clientId;
  final String? practionerId;
  final String? practionerName;
  final String? services;
  final String? date;
  final String? time;
  final String? location;
  final String? clientNameorCode;
  final String? clientEmail;
  final String? clientphNumber;
  final String? clientComment;
  final String? statusAppointment;
  final String? createdAt;

  AppointmentData(
      {this.clientId,
      this.practionerId,
      this.practionerName,
      this.services,
      this.date,
      this.time,
      this.location,
      this.clientNameorCode,
      this.clientEmail,
      this.clientphNumber,
      this.clientComment,
      this.statusAppointment,
      this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      "clientId": clientId,
      "practionerId": practionerId,
      "practionerName": practionerName,
      "services": services,
      "date": date,
      "time": time,
      "location": location,
      "clientNameorCode": clientNameorCode,
      "clientEmail": clientEmail,
      "clientphNumber": clientphNumber,
      "clientComment": clientComment,
      "statusAppointment": statusAppointment,
      "createdAt": createdAt,
    };
  }

  AppointmentData.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : clientId = doc.data()!["clientId"],
        practionerId = doc.data()!["practionerid"],
        practionerName = doc.data()!["practionerName"],
        services = doc.data()!["services"],
        date = doc.data()!["date"],
        time = doc.data()!["time"],
        location = doc.data()!["location"],
        clientNameorCode = doc.data()!["clientNameorCode"],
        clientEmail = doc.data()!["clientEmail"],
        clientphNumber = doc.data()!["clientphNumber"],
        clientComment = doc.data()!["clientComment"],
        statusAppointment = doc.data()!["statusAppointment"],
        createdAt = doc.data()!["createdAt"];
}
