import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/model/user_data.dart';

class changeStatusAppointmentNotifier extends StateNotifier<IsLoading> {
  changeStatusAppointmentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editAppointmentCancel({
    required AppointmentData appointmentData,
  }) async {
    try {
      isLoading = true;
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.appointment,
          )
          .where(
            FirebaseFieldName.statusAppointment,
            isEqualTo: "ongoing",
          )
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FirebaseFieldName.statusAppointment: "Cancel",
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
