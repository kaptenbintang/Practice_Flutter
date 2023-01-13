import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:login_uix_firebase/provider/appointment_page/appointment_upload_notifier.dart';

//provide bool isloading value

final appointmentUploaderProvider =
    StateNotifierProvider<AppointmentUploadNotifier, IsLoading>(
  (ref) => AppointmentUploadNotifier(),
);
