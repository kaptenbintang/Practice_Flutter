import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';
import 'package:login_uix_firebase/provider/time_schedule/schedule_notifier.dart';

final editStartTimePractioner =
    StateNotifierProvider<changeStatusStartTime, IsLoading>(
  (ref) => changeStatusStartTime(),
);

final editEndTimePractioner =
    StateNotifierProvider<changeStatusEndTime, IsLoading>(
  (ref) => changeStatusEndTime(),
);
