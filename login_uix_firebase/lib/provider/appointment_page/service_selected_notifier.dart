import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class ServicesNotifier extends ChangeNotifier {
//   final service = '';

//   void changeServices(String selected) {
//     service == selected;
//     notifyListeners();
//   }
// }

class ServicesNotifier extends StateNotifier<String> {
  ServicesNotifier() : super('');

  void selectedService(String service) {
    state = service;
  }
}
