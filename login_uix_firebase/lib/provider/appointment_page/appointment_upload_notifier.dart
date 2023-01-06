import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/model/appointment/appointment_payload.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentUploadNotifier extends StateNotifier<IsLoading> {
  AppointmentUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required AppointmentData appointmentData,
  }) async {
    isLoading = true;

    final nowTime = DateTime.now();

    try {
      final appointmentPayload = AppointmentPayload(
        userId: appointmentData.clientId.toString(),
        practionerId: appointmentData.practionerId.toString(),
        practionerName: appointmentData.practionerName.toString(),
        services: appointmentData.services.toString(),
        date: appointmentData.date.toString(),
        time: appointmentData.time.toString(),
        location: appointmentData.location.toString(),
        clientNameorCode: appointmentData.clientNameorCode.toString(),
        clientEmail: appointmentData.clientEmail.toString(),
        clientphNumber: appointmentData.clientphNumber.toString(),
        clientComment: appointmentData.clientComment ?? '',
        statusAppointment: appointmentData.statusAppointment ?? 'ongoing',
        createdAt: nowTime.toString(),
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.appointment)
          .add(
            appointmentPayload,
          );
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
