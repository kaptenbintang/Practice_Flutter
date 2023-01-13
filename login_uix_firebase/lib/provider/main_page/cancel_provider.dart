import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'cancel_notifier.dart';

//provide bool edit status appointment value

final editStatusAppointment =
    StateNotifierProvider<ChangeStatusAppointmentNotifier, IsLoading>(
  (ref) => ChangeStatusAppointmentNotifier(),
);
