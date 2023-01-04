import 'package:hooks_riverpod/hooks_riverpod.dart';

class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(DateTime.now());

  void changeDate(DateTime date) {
    state = date;
  }
}
