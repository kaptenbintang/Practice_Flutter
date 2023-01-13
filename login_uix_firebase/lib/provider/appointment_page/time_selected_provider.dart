import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_selected_notifier.dart';

//provide timeselected string value

final timeSelectedProvider =
    StateNotifierProvider<TimeSelectedNotifier, String>((ref) {
  return TimeSelectedNotifier();
});
