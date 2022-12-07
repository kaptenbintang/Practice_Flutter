import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class PowerChecker {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getRoles(String role) async {
    QuerySnapshot<Map<String, dynamic>> response =
        await _db.collection('roles').where('rolesName', isEqualTo: role).get();
    final snapshot = response.docs[0];
    return snapshot.data();
  }
}

// final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
//   return FirebaseAuth.instance;
// });

// final authStateProvider = StreamProvider<User?>((ref) {
//   return ref.watch(firebaseAuthProvider).authStateChanges();
// });

// final databaseProvider = Provider.autoDispose<FirebaseStorage?>((ref) {
//   final auth = ref.watch(authStateProvider);

//   if (auth.asData?.value?.uid != null) {
//     return;
//   }
//   return null;
// });
