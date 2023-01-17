import 'package:flutter/foundation.dart' show immutable;

// field name at services table firestore

@immutable
class EventsKey {
  static const eventsDate = 'eventsDate';
  static const eventsLocation = 'eventsLocation';
  static const eventsPrice = 'eventsPrice';
  static const eventsTitle = 'eventsTitle';
  static const eventsDescription = 'eventsDescription';

  const EventsKey._();
}
