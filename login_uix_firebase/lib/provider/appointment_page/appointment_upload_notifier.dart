import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/appointment/appointment_payload.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// API upload appointment to firestore
class AppointmentUploadNotifier extends StateNotifier<IsLoading> {
  AppointmentUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required AppointmentPayload appointmentData,
  }) async {
// show loading
    isLoading = true;

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
      // dissmissed loading
      isLoading = false;
    }
  }
}
