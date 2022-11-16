import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/roles_data.dart';

import '../model/user_data.dart';

class DataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(UserData employeeData) async {
    await _db.collection("users").add(employeeData.toMap());
  }

  Future<void> updateUser(UserData employeeData) async {
    await _db
        .collection("users")
        .doc(employeeData.id)
        .update(employeeData.toMap());
  }

  Future<void> deleteUser(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("users").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Deleted Account"),
            );
          },
        );
      },
    );
  }

  Future<List<UserData>> retrieveAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
        .toList();

    // final ref = _db.collection("users").doc().withConverter(
    //       fromFirestore: UserData.fromFirestore,
    //       toFirestore: (UserData data, _) => data.toFireStore(),
    //     );
    // final docSnap = await ref.get();
    // return docSnap.data();
  }

  Future<List<UserData>> retrieveClient() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").where("roles", isEqualTo: 'user').get();
    return snapshot.docs
        .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<RolesData>> retrieveRoles() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("roles").get();
    return snapshot.docs
        .map((docSnapshot) => RolesData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<Map<String, dynamic>> currentUsers(uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").doc(uid).get();
    Map<String, dynamic>? data = snapshot.data();
    return data!;
  }
}
