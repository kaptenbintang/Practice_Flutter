import 'package:flutter/foundation.dart' show immutable;

// field name at services table firestore

@immutable
class ServicesKey {
  static const categoryName = 'categoryName';
  static const duration = 'duration';
  static const price = 'price';
  static const servicesName = 'servicesName';

  const ServicesKey._();
}
