import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/model/location_models/location_key.dart';

// object model for storaging Location data from firestore

@immutable
class Location {
  final String locationId;
  final String type;

  Location({
    required this.locationId,
    required Map<String, dynamic> json,
  }) : type = json[LocationKey.type];
}
