import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/model/practioner_models/practioner_key.dart';
import 'package:login_uix_firebase/model/practioner_models/schedule.dart';

@immutable
class Practioner {
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
  final Map schedules;
  final Map dayoff;

  // final String practionerSchedule;

  Practioner({
    required this.userId,
    required Map<String, dynamic> json,
  })  : firstName = json[PractionerKey.firstName],
        lastName = json[PractionerKey.lastName],
        myApproach = json[PractionerKey.myApproach],
        myBackground = json[PractionerKey.myBackground],
        myQualifications = json[PractionerKey.myQualifications],
        myRoles = json[PractionerKey.myRoles],
        mySpecialty = json[PractionerKey.mySpecialty],
        languages = json[PractionerKey.languages],
        titleMain = json[PractionerKey.titleMain],
        schedules = json[PractionerKey.schedules],
        dayoff = json[PractionerKey.dayoff];
  // schedules = {
  //   for(final entry in json[PractionerKey.schedules].entries)
  //   Schedule.values.firstWhere((element) => element.dayName == entry.key,

  //   ): entry.value,};

  // practionerSchedule = json[PractionerKey.practionerSchedule];

  // bool get allowsLikes => postSettings[PostSetting.allowLikes] ?? false;
  // bool get allowsComments => postSettings[PostSetting.allowComments] ?? false;
}
