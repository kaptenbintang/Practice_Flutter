import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/appointment_page/date_selected_provider.dart';

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref) {
  return DateNotifier();
});
