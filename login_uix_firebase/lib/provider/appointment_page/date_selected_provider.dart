import 'package:hooks_riverpod/hooks_riverpod.dart';

class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(DateTime.now());

  void changeDate(DateTime date) {
    state = date;
  }
}

class DateRangeNotifier extends StateNotifier<String> {
  DateRangeNotifier() : super(DateTime.now().toString());

  void changeDateRange(String date) {
    state = date;
  }
}
