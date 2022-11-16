import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RolesData {
  final String? id;
  final String? rolesName;
  late final bool? canWrite;
  final bool? canRead;
  final bool? canDelete;

  RolesData({
    this.id,
    this.rolesName,
    this.canWrite,
    this.canRead,
    this.canDelete,
  });

  Map<String, dynamic> toMap() {
    return {
      "rolesName": rolesName,
      "canWrite": canWrite,
      "canRead": canRead,
      "canDelete": canDelete,
    };
  }

  RolesData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        rolesName = doc.data()!["rolesName"],
        canWrite = doc.data()!["canWrite"],
        canRead = doc.data()!["canRead"],
        canDelete = doc.data()!["canDelete"];
}
