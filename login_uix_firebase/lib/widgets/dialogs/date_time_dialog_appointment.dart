import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/provider/appointment_page/date_selected.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_auto_change_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeAppointmentDialog extends ConsumerStatefulWidget {
  final Map dayoff;
  final BuildContext context;
  const DateTimeAppointmentDialog(
      {Key? key, required this.dayoff, required this.context})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DateTimeAppointmentDialogState();
}

class _DateTimeAppointmentDialogState
    extends ConsumerState<DateTimeAppointmentDialog> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  final dateandtimeController = TextEditingController();

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;
      ref.read(dateProvider.notifier).changeDate(selectedDate);
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(dateProvider);

    final dasd = dadsa(widget.dayoff);

    final deleteList = dasd.toSet().toList();

    return AlertDialog(
      title: Text('Please choose date'),
      content: Center(
        child: SizedBox(
          width: 500,
          height: 700,
          child: SfDateRangePicker(
            showNavigationArrow: true,
            onSelectionChanged: _onSelectionChanged,
            view: DateRangePickerView.month,

            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
              firstDayOfWeek: 1,
              numberOfWeeksInView: 3,
              blackoutDates: deleteList,
              weekendDays: [7, 6],
              specialDates: [
                DateTime(2023, 1, 5),
                DateTime(2023, 1, 15),
                DateTime(2023, 1, 14),
              ],
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              blackoutDatesDecoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: const Color(0xFFF44436), width: 1),
                  shape: BoxShape.circle),
              weekendDatesDecoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF),
                  border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                  shape: BoxShape.circle),
              specialDatesDecoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: const Color(0xFF2B732F), width: 1),
                  shape: BoxShape.circle),
              blackoutDateTextStyle: TextStyle(
                  color: Colors.white, decoration: TextDecoration.lineThrough),
              specialDatesTextStyle: const TextStyle(color: Colors.white),
            ),
            selectionMode: DateRangePickerSelectionMode.single,
            // controller: _datePickerController,
            selectionRadius: 25,
            // selectionShape: DateRangePickerSelectionShape.rectangle,
            // initialSelectedRange: PickerDateRange(
            //     DateTime.now(), DateTime.now().add(Duration(days: 3))),
            showActionButtons: true,
            minDate: DateTime.now(),
            // toggleDaySelection: true,
            onSubmit: (_) {
              ref.read(dateChangeProvider.notifier).state = true;
              Navigator.pop(
                context,
                DateFormat('EEE, yyyy-MM-dd').format(selectedDate),
              );
            },
            onCancel: () {
              selectedDate == null || selectedDate == DateTime.now()
                  ? Navigator.pop(context)
                  : ref.read(dateChangeProvider.notifier).state = false;

              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

List<DateTime> dadsa(Map dayoff) {
  List<DateTime> dayOffList = [];

  for (var i = 0; i <= dayoff.length - 1; i++) {
    final offValues = dayoff.values.elementAt(i);
    // print('e $e');

    print(offValues);
    final startDayoff = DateFormat('dd/MM/yyyy').parse(offValues['dateDayoff']);
    final endDayoff =
        DateFormat('dd/MM/yyyy').parse(offValues['dateDayoffEnd']);
    final ddd = endDayoff.difference(startDayoff);
    print(ddd.inDays);

    for (var y = 0; y <= ddd.inDays; y++) {
      dayOffList.add(startDayoff.add(Duration(days: y)));
    }
    print(dayOffList);
  }
  return dayOffList;
}
