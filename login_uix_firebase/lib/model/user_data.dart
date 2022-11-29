import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData {
  final String? id;
  final String firstName;
  final String lastName;
  final String emailUser;
  // final int ageUser;
  final String? clientCode;
  final String? roles;
  // final String? imgUrl;
  final String doBirth;
  final String phoneNumber;
  final String? clientType;
  final String? createdAt;
  final bool? markDeleted;

  UserData({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.emailUser,
    // required this.ageUser,
    this.clientCode,
    this.roles,
    // this.imgUrl,
    required this.doBirth,
    required this.phoneNumber,
    this.clientType,
    this.createdAt,
    this.markDeleted,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      // "age": ageUser,
      "email": emailUser,
      "clientcode": clientCode,
      "roles": roles,
      // "imageUrl": imgUrl,
      "phoneNumber": phoneNumber,
      "dateofbirth": doBirth,
      "clientType": clientType,
      "createdAt": createdAt,
      "markDeleted": markDeleted,
    };
  }

  // factory UserData.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return UserData(
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

  UserData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        firstName = doc.data()!["firstName"],
        lastName = doc.data()!["lastName"],
        emailUser = doc.data()!["email"],
        // ageUser = doc.data()!["age"],
        clientCode = doc.data()!["clientcode"],
        roles = doc.data()!["roles"],
        // imgUrl = doc.data()!["imageUrl"],
        phoneNumber = doc.data()!["phoneNumber"],
        doBirth = doc.data()!["dateofbirth"],
        clientType = doc.data()!["clientType"],
        createdAt = doc.data()!["createdAt"],
        markDeleted = doc.data()!["markDeleted"];
}
