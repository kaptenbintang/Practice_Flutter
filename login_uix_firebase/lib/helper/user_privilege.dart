import 'package:cloud_firestore/cloud_firestore.dart';

class PowerChecker {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getRoles(String role) async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _db.collection('roles').where('rolesName', isEqualTo: role).get();
    final snapshot = response.docs[0];
    return snapshot.data();
  }
}
