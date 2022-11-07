import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final String? id;
  final String firstName;
  final String lastName;
  final String emailUser;
  final int ageUser;

  UserData(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.emailUser,
      required this.ageUser});

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "age": ageUser,
      "email": emailUser,
    };
  }

  UserData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        firstName = doc.data()!["firstName"],
        lastName = doc.data()!["lastName"],
        emailUser = doc.data()!["email"],
        ageUser = doc.data()!["age"];
}
