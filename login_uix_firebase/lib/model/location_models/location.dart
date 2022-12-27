import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/model/location_models/location_key.dart';
import 'package:login_uix_firebase/model/services/services_key.dart';

@immutable
class Location {
  final String locationId;
  final String type;

  Location({
    required this.locationId,
    required Map<String, dynamic> json,
  }) : type = json[LocationKey.type];

  // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}
