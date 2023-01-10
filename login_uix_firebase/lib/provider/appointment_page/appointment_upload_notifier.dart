import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/appointment/appointment_payload.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentUploadNotifier extends StateNotifier<IsLoading> {
  AppointmentUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required AppointmentPayload appointmentData,
  }) async {
    isLoading = true;

    final nowTime = DateTime.now();

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.appointment)
          .add(
            appointmentData,
          );
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

class blackoutUploadNotifier extends StateNotifier<IsLoading> {
  blackoutUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required PractionerData practionerData,
  }) async {
    isLoading = true;

    try {
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
