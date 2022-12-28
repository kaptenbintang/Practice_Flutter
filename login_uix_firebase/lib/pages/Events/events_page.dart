// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/Events/event_desktop.dart';
import 'package:login_uix_firebase/pages/Events/event_mobile.dart';

import '../../helper/responsive.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return EventDesktop();
    } else {
      return EventMobile();
    }
  }
}
