import 'package:flutter/foundation.dart' show immutable;

// field name at Practioner table firestore

@immutable
class PractionerKey {
  static const userId = 'uid';
  static const firstName = 'firstName';
  static const lastName = 'lastName';
  static const myApproach = 'myApproach';
  static const myBackground = 'myBackground';
  static const myQualifications = 'myQualifications';
  static const myRoles = 'myRoles';
  static const mySpecialty = 'mySpecialty';
  static const profilePic = 'profilePic';
  static const languages = 'languages';
  static const titleMain = 'titleMain';
  static const schedules = 'schedules';
  static const dayoff = 'dayoff';
  static const blackout = 'blackout';

  const PractionerKey._();
}
