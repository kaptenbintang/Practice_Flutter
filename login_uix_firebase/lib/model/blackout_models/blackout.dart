import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/model/blackout_models/blackout_key.dart';

@immutable
class Blackout {
  final String blackoutId;
  final String valueId;
  final String valueName;

  Blackout({
    required this.blackoutId,
    required Map<String, dynamic> json,
  })  : valueId = json[BlackoutKey.valueId],
        valueName = json[BlackoutKey.valueName];

  // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}
