// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/pages/historybookingpage/history_booking_desktop.dart';
import 'package:login_uix_firebase/pages/historybookingpage/history_booking_mobile.dart';

import '../../helper/responsive.dart';

class historyBookingRiverpod extends ConsumerStatefulWidget {
  const historyBookingRiverpod({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _historyBookingRiverpodState();
}

class _historyBookingRiverpodState
    extends ConsumerState<historyBookingRiverpod> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return historyBookingDesktop();
    } else {
      return historyBookingMobile();
    }
  }
}
