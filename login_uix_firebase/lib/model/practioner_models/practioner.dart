import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/model/practioner_models/practioner_key.dart';

// object model for storaging Practioner data from firestore

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
  final String profilePic;
  final String languages;
  final String titleMain;
  final Map schedules;
  final Map dayoff;

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
        profilePic = json[PractionerKey.profilePic],
        languages = json[PractionerKey.languages],
        titleMain = json[PractionerKey.titleMain],
        schedules = json[PractionerKey.schedules],
        dayoff = json[PractionerKey.dayoff];
}
