import 'package:cloud_firestore/cloud_firestore.dart';

class EventsData {
  final String? id;
  final Timestamp? eventsDate;
  final String? eventsLocation;
  final String? eventsPrice;
  final String? eventsTitle;
  final String? eventsDescription;
  final String? eventsImage;

  EventsData(
      {this.id,
      this.eventsDate,
      this.eventsLocation,
      this.eventsPrice,
      this.eventsTitle,
      this.eventsDescription,
      this.eventsImage});

  Map<String, dynamic> toMap() {
    return {
      "eventsDate": eventsDate,
      "eventsLocation": eventsLocation,
      "eventsPrice": eventsPrice,
      "eventsTitle": eventsTitle,
      "eventsDescription": eventsDescription,
      "eventsImage": eventsImage,
    };
  }

  EventsData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        eventsDate = doc.data()!["eventsDate"],
        eventsLocation = doc.data()!["eventsLocation"],
        eventsPrice = doc.data()!["eventsPrice"],
        eventsTitle = doc.data()!["eventsTitle"],
        eventsImage = doc.data()!["eventsImage"],
        eventsDescription = doc.data()!["eventsDescription"];
}
