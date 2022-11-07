import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_data.dart';

class DataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(UserData employeeData) async {
    await _db.collection("users").add(employeeData.toMap());
  }

  updateUser(UserData employeeData) async {
    await _db
        .collection("users")
        .doc(employeeData.id)
        .update(employeeData.toMap());
  }

  Future<void> deleteUser(String documentId) async {
    await _db.collection("users").doc(documentId).delete();
  }

  Future<List<UserData>> retrieveUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").get();
    return snapshot.docs
        .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
