import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';

class EditUserNotifier extends StateNotifier<IsLoading> {
  EditUserNotifier() : super(false);

  set isLoading(bool value) => state = value;
  // final _authenticator = const Authenticator();

  // EditUserNotifier() : super(const AuthState.unknown()) {
  //   if (_authenticator.isAlreadyLoggedIn) {
  //     state = AuthState(
  //       result: AuthResult.success,
  //       isLoading: false,
  //       userId: _authenticator.userId,
  //     );
  //   }
  // }

  // set mapData(bool value) => state = value;

  Future<bool> editUser({
    required UserData userData,
  }) async {
    try {
      isLoading = true;
      // final userId = FirebaseAuth.instance.currentUser!.uid;
      // mapData = true;

      // DataService.updateUserI(userData);
      // print(userId);
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userData.id.toString(),
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.firstName: userData.firstName,
            FirebaseFieldName.lastName: userData.lastName,
            FirebaseFieldName.phoneNumber: userData.phoneNumber ?? '',
            FirebaseFieldName.dateofbirth: userData.doBirth ?? '',
          },
        );
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
