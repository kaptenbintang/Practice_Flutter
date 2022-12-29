import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeAppointmentDialog extends ConsumerStatefulWidget {
  final String practioner;
  final BuildContext context;
  const DateTimeAppointmentDialog(
      {Key? key, required this.practioner, required this.context})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DateTimeAppointmentDialogState();

  // @override
  // State<DateTimeAppointmentDialog> createState() =>
  //     _DateTimeAppointmentDialogState();
}

class _DateTimeAppointmentDialogState
    extends ConsumerState<DateTimeAppointmentDialog> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  final dateandtimeController = TextEditingController();
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  // @override
  // void initState() {
  //   // _datePickerController.selectedDate = DateTime.now().add(Duration(days: 2));
  //   mockBookingService = BookingService(
  //     serviceName: 'Mock Service',
  //     serviceDuration: 15,
  //     bookingEnd: DateTime(now.year, now.month, now.day, 19, 30),
  //     bookingStart: DateTime(now.year, now.month, now.day, 9, 0),
  //   );
  //   super.initState();
  // }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      // final DateTime rangeStartDate = args.value.startDate;
      // final DateTime rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
      final DateTime selectedDate = args.value;

      // final dataFormated = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        _datePickerController.selectedDate = selectedDate;
      });
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please choose date'),
      content: Center(
        child: SizedBox(
          width: 500,
          height: 700,
          // constraints: BoxConstraints(minWidth: 300, minHeight: 250),
          child: SfDateRangePicker(
            // rangeTextStyle: TextStyle(
            //     fontStyle: FontStyle.italic,
            //     fontWeight: FontWeight.w500,
            //     fontSize: 50,
            //     color: Colors.black),

            showNavigationArrow: true,
            onSelectionChanged: _onSelectionChanged,
            view: DateRangePickerView.month,
            monthViewSettings: DateRangePickerMonthViewSettings(
              dayFormat: 'EEE',
              firstDayOfWeek: 1,
              numberOfWeeksInView: 3,
              blackoutDates: <DateTime>[
                DateTime.now().add(Duration(days: 2)),
                DateTime.now().add(Duration(days: 3)),
                DateTime.now().add(Duration(days: 6)),
                DateTime.now().add(Duration(days: 7)),
              ],
              weekendDays: [7, 6],
              specialDates: [
                DateTime(2023, 1, 5),
                DateTime(2022, 12, 27),
                DateTime(2022, 12, 28)
              ],
            ),
            selectionMode: DateRangePickerSelectionMode.single,
            controller: _datePickerController,
            selectionRadius: 25,
            // selectionShape: DateRangePickerSelectionShape.rectangle,
            // initialSelectedRange: PickerDateRange(
            //     DateTime.now(), DateTime.now().add(Duration(days: 3))),
            showActionButtons: true,
            minDate: DateTime.now(),
            // toggleDaySelection: true,
            onSubmit: (p0) {
              Navigator.pop(
                context,
                DateFormat('yyyy-MM-dd')
                    .format(_datePickerController.selectedDate as DateTime),
              );
            },
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
