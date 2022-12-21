import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/model/practioner_models/practioner_key.dart';

@immutable
class Practioner {
  final String practionerId;
  final String userId;
  final String firstName;
  final String lastName;
  final String myApproach;
  final String myBackground;
  final String myQualifications;
  final String myRoles;
  final String mySpecialty;
  final String languages;
  final String titleMain;
  // final String practionerSchedule;

  Practioner({
    required this.practionerId,
    required Map<String, dynamic> json,
  })  : userId = json[PractionerKey.userId],
        firstName = json[PractionerKey.firstName],
        lastName = json[PractionerKey.lastName],
        myApproach = json[PractionerKey.myApproach],
        myBackground = json[PractionerKey.myBackground],
        myQualifications = json[PractionerKey.myQualifications],
        myRoles = json[PractionerKey.myRoles],
        mySpecialty = json[PractionerKey.mySpecialty],
        languages = json[PractionerKey.languages],
        titleMain = json[PractionerKey.titleMain];
  // practionerSchedule = json[PractionerKey.practionerSchedule];

  // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}
