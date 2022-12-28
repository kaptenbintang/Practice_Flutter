import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  @override
  void initState() {
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 9, 0));
    super.initState();
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    setState(() {
      dateandtimeController.text = DateFormat('EEE, yyyy-MM-dd, kk:mm:a')
          .format(newBooking.bookingStart)
          .toString();
      Navigator.pop(context, dateandtimeController.text);
    });
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please choose date'),
      content: Center(
        child: Container(
          width: 600,
          child: BookingCalendar(
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            pauseSlots: generatePauseSlots(),
            pauseSlotText: 'LUNCH',
            hideBreakTime: false,
            loadingWidget: Align(
                alignment: Alignment.center,
                child: const Text('Fetching data...')),
            uploadingWidget: Align(
                alignment: Alignment.center,
                child: const Text('Submitting data...')),
            locale: 'en_EN',
            startingDayOfWeek: StartingDayOfWeek.monday,
            disabledDays: const [6, 7],
          ),
        ),
      ),
    );
  }
}
