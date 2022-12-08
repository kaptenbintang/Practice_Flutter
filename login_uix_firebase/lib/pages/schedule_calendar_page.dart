import 'package:flutter/material.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  /// Dropdown list items for recurrenceType
  List<String> _repeatOption = <String>[
    'Never',
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly'
  ];

  /// Dropdown list items for day of week
  List<String> _weekDay = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  /// Dropdown list items for end range
  List<String> _ends = <String>[
    'Never',
    'Until',
    'Count',
  ];

  /// Dropdown list items for months of year
  List<String> _dayMonths = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  /// Dropdown list items for week number of the month.
  List<String> _daysPosition = <String>[
    'First',
    'Second',
    'Third',
    'Fourth',
    'Last'
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
