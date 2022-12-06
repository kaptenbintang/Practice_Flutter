import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/user_data.dart';

class EditUserNotifier extends StateNotifier<UserData?> {
  EditUserNotifier() : super(null);

  Future<bool> editUser({
    required UserData userData,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.id)
          .update(userData.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }
}
