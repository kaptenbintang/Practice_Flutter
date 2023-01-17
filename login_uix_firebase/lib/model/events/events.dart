import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/model/Events/Events_key.dart';

// object model for storing Events data from firestore

@immutable
class Events {
  final String EventsId;
  final Timestamp eventsDate;
  final String eventsLocation;
  final String eventsPrice;
  final String eventsTitle;
  final String eventsDescription;

  Events({
    required this.EventsId,
    required Map<String, dynamic> json,
  })  : eventsDate = json[EventsKey.eventsDate],
        eventsLocation = json[EventsKey.eventsLocation],
        eventsPrice = json[EventsKey.eventsPrice],
        eventsTitle = json[EventsKey.eventsTitle],
        eventsDescription = json[EventsKey.eventsDescription];
}
