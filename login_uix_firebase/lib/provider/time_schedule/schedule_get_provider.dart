import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:login_uix_firebase/provider/time_schedule/schedule_notifier.dart';

//callback changeStatusStartTime class

final editStartTimePractioner =
    StateNotifierProvider<ChangeStatusStartTime, IsLoading>(
  (ref) => ChangeStatusStartTime(),
);

//callback changeStatusEndTime class

final editEndTimePractioner =
    StateNotifierProvider<ChangeStatusEndTime, IsLoading>(
  (ref) => ChangeStatusEndTime(),
);
