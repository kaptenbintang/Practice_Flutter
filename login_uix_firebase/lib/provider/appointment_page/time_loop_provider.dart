import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/model/time_models/time.dart';
import 'package:login_uix_firebase/provider/appointment_page/date_selected_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';

//provide list of time

final timeLoopProvider =
    FutureProvider.autoDispose.family<List, Map>((ref, schedules) async {
  String initService = ref.watch(selectedServiceProvider);
  final selectedDate = ref.watch(dateProvider);

  final dateSelecteds = DateFormat('EEE, yyyy-MM-dd').format(selectedDate);
  final intValue = int.parse(initService.replaceAll(RegExp('[^0-9]'), ''));
  final dayName = dateSelecteds.split(",").elementAt(0);
  final time = schedules;

  List loopTime = [];
  String startTime, endTime;

  time.forEach((key, value) {
    if (value['dayName'].toString().contains(dayName)) {
      startTime = value['startTime'];
      endTime = value['endTime'];
      DateTime dateTimeStart = DateTime.parse('0000-00-00 $startTime:00');
      final dateTimeEnd = DateTime.parse('0000-00-00 $endTime:00');
      final diff = dateTimeEnd.difference(dateTimeStart);

      for (int i = 0; i <= diff.inMinutes / intValue; i++) {
        String formattedTime = DateFormat.Hm().format(dateTimeStart);
        // loopTime.add(formattedTime);
        loopTime.add(TimeModel(timeStamp: formattedTime, isSelected: false));
        dateTimeStart = dateTimeStart.add(Duration(minutes: intValue));
      }
    }
  });

  return loopTime;
});
