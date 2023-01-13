import 'package:cloud_firestore/cloud_firestore.dart';

class DayName {
  final String? uniqueid;
  final int? id;
  final String? name;
  final String? practionerId;

  DayName({
    this.uniqueid,
    this.id,
    this.name,
    this.practionerId,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "practionerId": practionerId,
    };
  }

  DayName.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uniqueid = doc.id,
        id = doc.data()!["id"],
        name = doc.data()!["name"],
        practionerId = doc.data()!["practionerId"];
}
