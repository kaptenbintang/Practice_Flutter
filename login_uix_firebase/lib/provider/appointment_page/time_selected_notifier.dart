import 'package:hooks_riverpod/hooks_riverpod.dart';

//change string time value

class TimeSelectedNotifier extends StateNotifier<String> {
  TimeSelectedNotifier() : super('');

  void selectedTime(String time) {
    state = time;
  }
}
