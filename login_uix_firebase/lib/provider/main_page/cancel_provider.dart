import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'cancel_notifier.dart';

final editStatusAppointment =
    StateNotifierProvider<changeStatusAppointmentNotifier, IsLoading>(
  (ref) => changeStatusAppointmentNotifier(),
);
