import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/provider/appointment_page/date_selected.dart';
import 'package:login_uix_firebase/provider/appointment_page/services_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_auto_change_provider.dart';

// class Parameters extends Equatable {
//   const Parameters({
//     required this.schedules,
//     required this.serviceTipe,
//     required this.dateSelected,
//   });

//   final Map<dynamic, dynamic> schedules;
//   final String serviceTipe;
//   final String dateSelected;

//   @override
//   List<Object> get props => [schedules, serviceTipe, dateSelected];
// }

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
        print(loopTime);
        String formattedTime = DateFormat.Hm().format(dateTimeStart);
        // loopTime.add('${dateTimeStart.hour}:${dateTimeStart.minute}');
        loopTime.add(formattedTime);
        dateTimeStart = dateTimeStart.add(Duration(minutes: intValue));
      }
    }
  });

  return loopTime;
});

// void main() {
//   final eee = {1: {'endTime': '18:30', 'startTime': '11:45', 'dayName': 'Monday'}, 2: {'endTime': '18:53', 'dayName': 'Tuesday', 'startTime': '11:53'}, 3: {'endTime': '18:53', 'startTime': '6:53', 'dayName': 'Wednesday'}, 4: {'endTime': '18:54', 'startTime': '11:53', 'dayName': 'Thursday'}, 5: {'endTime': '18:54', 'startTime': '9:54', 'dayName': 'Friday'}, 6: {'endTime': '18:54', 'dayName': 'Saturday', 'startTime': '11:54'}, 7: {'startTime': '6:54', 'dayName': 'Sunday', 'endTime': '19:54'}};
//   String ee = 'maling';
//   eee.forEach((key,val){
//     if(val['dayName'].toString().contains('Mon')){
//       final startTime = val['startTime'].toString();
//       final endTime = val['endTime'];

      
//       DateTime dateTimeStart = DateTime.parse('0000-00-00 ${startTime}:00');
//       final dateTimeEnd = DateTime.parse('0000-00-00 ${endTime}:00');
//       final diff = dateTimeStart.difference(dateTimeEnd);
//       var ee;
//       List loopTime = [dateTimeStart];
      
      

//       print(startTime.toString() + ' ' + endTime.toString());
//       print(diff.inMinutes);
//       print(diff.inMinutes / 30 * -1);
      
      
//       for (int i =0;i<=13.5;i++) {
//         print(loopTime);
 
//      dateTimeStart = dateTimeStart.add(Duration(minutes: 30));
//             loopTime.add(dateTimeStart);
//           }
//         print(loopTime);
      
      
//     }
//   });
//   print(ee[3][0]);
//   print(ee[5]);
//   //   for (int i = 0; i < 5; i++) {
// //     print('hello ${i + 1}');
// //   }
// }
