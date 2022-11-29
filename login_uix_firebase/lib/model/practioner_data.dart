import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PractionerData {
  final String? id;
  final String? firstName;
  final String? lastName;

  PractionerData({
    this.id,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  // factory PractionerData.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return PractionerData(
  //     firstName: data?['firstName'],
  //     lastName: data?['lastName'],
  //     emailUser: data?['email'],
  //     ageUser: data?['age'],
  //   );
  // }

  // Map<String, dynamic> toFireStore() {
  //   return {
  //     if (firstName != null) "firstName": firstName,
  //     if (lastName != null) "lastName": lastName,
  //     if (emailUser != null) "email": emailUser,
  //     if (ageUser != null) "age": ageUser,
  //   };
  // }

  PractionerData.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        firstName = doc.data()!["firstName"],
        lastName = doc.data()!["lastName"];
}
