import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:login_uix_firebase/model/user_data.dart';

class EditUserNotifier extends StateNotifier<bool> {
  EditUserNotifier() : super(false);

  set mapData(bool value) => state = value;

  Future<bool> editUser({
    required UserData userData,
  }) async {
    try {
      // final userId = FirebaseAuth.instance.currentUser!.uid;
      mapData = true;

      // DataService.updateUserI(userData);
      // print(userId);

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
