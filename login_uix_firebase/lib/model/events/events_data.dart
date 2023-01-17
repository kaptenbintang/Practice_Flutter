import 'package:cloud_firestore/cloud_firestore.dart';

class EventsData {
  final String? EventsId;
  final Timestamp? eventsDate;
  final String? eventsLocation;
  final String? eventsPrice;
  final String? eventsTitle;
  final String? eventsDescription;

  EventsData({
    this.EventsId,
    this.eventsDate,
    this.eventsLocation,
    this.eventsPrice,
    this.eventsTitle,
    this.eventsDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      "eventsDate": eventsDate,
      "eventsLocation": eventsLocation,
      "eventsPrice": eventsPrice,
      "eventsTitle": eventsTitle,
      "eventsDescription": eventsDescription,
    };
  }

  EventsData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : EventsId = doc.id,
        eventsDate = doc.data()!["eventsDate"],
        eventsLocation = doc.data()!["eventsLocation"],
        eventsPrice = doc.data()!["eventsPrice"],
        eventsTitle = doc.data()!["eventsTitle"],
        eventsDescription = doc.data()!["eventsDescription"];
}
