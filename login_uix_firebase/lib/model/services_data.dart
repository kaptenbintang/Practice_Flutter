import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServicesData {
  final String? id;
  final String? servicesName;
  final String? duration;
  final String? categoryName;
  final String? price;

  ServicesData({
    this.id,
    this.servicesName,
    this.duration,
    this.categoryName,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "servicesName": servicesName,
      "duration": duration,
      "categoryName": categoryName,
      "price": price,
    };
  }

  ServicesData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        servicesName = doc.data()!["servicesName"],
        duration = doc.data()!["duration"],
        categoryName = doc.data()!["categoryName"],
        price = doc.data()!["price"];
}
