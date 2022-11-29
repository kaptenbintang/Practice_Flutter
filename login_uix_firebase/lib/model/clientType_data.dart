import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientData {
  final String? id;
  final String? ctName;

  ClientData({
    this.id,
    this.ctName,
  });

  Map<String, dynamic> toMap() {
    return {
      "ctName": ctName,
    };
  }

  ClientData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        ctName = doc.data()!["ctName"];
}
