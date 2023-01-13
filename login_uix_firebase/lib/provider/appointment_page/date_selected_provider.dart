import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/appointment_page/date_selected_notifier.dart';

//provide datetime value

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref) {
  return DateNotifier();
});

//provide string value

final dateRangeProvider =
    StateNotifierProvider<DateRangeNotifier, String>((ref) {
  return DateRangeNotifier();
});
