import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PractionerData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? myApproach;
  final String? myBackground;
  final String? myQualifications;
  final String? myRoles;
  final String? mySpecialty;
  final String? languages;
  final String? titleMain;
  final String? blackouts;

  PractionerData({
    this.id,
    this.firstName,
    this.lastName,
    this.myApproach,
    this.myBackground,
    this.myQualifications,
    this.myRoles,
    this.mySpecialty,
    this.languages,
    this.titleMain,
    this.blackouts,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "myApproach": myApproach,
      "myBackground": myBackground,
      "myQualifications": myQualifications,
      "myRoles": myRoles,
      "mySpecialty": mySpecialty,
      "languages": languages,
      "titleMain": titleMain,
      "blackouts": blackouts,
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
        lastName = doc.data()!["lastName"],
        myApproach = doc.data()!["myApproach"],
        myBackground = doc.data()!["myBackground"],
        myQualifications = doc.data()!["myQualifications"],
        myRoles = doc.data()!["myRoles"],
        mySpecialty = doc.data()!["mySpecialty"],
        languages = doc.data()!["languages"],
        titleMain = doc.data()!["titleMain"],
        blackouts = doc.data()!["blackouts"];
}
