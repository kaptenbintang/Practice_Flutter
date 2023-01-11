import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeSelectedNotifier extends StateNotifier<String> {
  TimeSelectedNotifier() : super('');

  void selectedTime(String time) {
    state = time;
  }
}
