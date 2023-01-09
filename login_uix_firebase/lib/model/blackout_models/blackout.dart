import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

// @immutable
// class Blackout {
//   final String blackoutId;
//   final String valueId;
//   final String valueName;

//   Blackout({
//     required this.blackoutId,
//     required Map<String, dynamic> json,
//   })  : valueId = json[BlackoutKey.valueId],
//         valueName = json[BlackoutKey.valueName];

//   // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
//   // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
// }

// // class DayName {
// //   const DayName(this.id, this.name);
// //   final String name;
// //   final int id;
// // }

// class blackoutPayload extends MapView<String, dynamic> {
//   blackoutPayload({
//     required UserId userId,
//     required String blackout,
//   }) : super(
//           {
//             BlackoutKey.valueName: userId,
//             BlackoutKey.valueId: blackout,
//           },
//         );
// }

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
