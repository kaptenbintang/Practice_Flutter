import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';

import 'cancel_notifier.dart';

final editStatusAppointment =
    StateNotifierProvider<changeStatusAppointmentNotifier, IsLoading>(
  (ref) => changeStatusAppointmentNotifier(),
);
