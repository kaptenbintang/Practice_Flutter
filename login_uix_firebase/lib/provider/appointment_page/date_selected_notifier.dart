import 'package:hooks_riverpod/hooks_riverpod.dart';

//change datetime datesingle
class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(DateTime.now());

  void changeDate(DateTime date) {
    state = date;
  }
}

//change string daterange
class DateRangeNotifier extends StateNotifier<String> {
  DateRangeNotifier() : super(DateTime.now().toString());

  void changeDateRange(String date) {
    state = date;
  }
}
