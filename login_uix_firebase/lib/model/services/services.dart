import 'package:flutter/foundation.dart';
import 'package:login_uix_firebase/model/services/services_key.dart';

// object model for storaging Services data from firestore

@immutable
class Services {
  final String servicesId;
  final String categoryName;
  final String duration;
  final String price;
  final String servicesName;

  Services({
    required this.servicesId,
    required Map<String, dynamic> json,
  })  : categoryName = json[ServicesKey.categoryName],
        duration = json[ServicesKey.duration],
        price = json[ServicesKey.price],
        servicesName = json[ServicesKey.servicesName];
}
