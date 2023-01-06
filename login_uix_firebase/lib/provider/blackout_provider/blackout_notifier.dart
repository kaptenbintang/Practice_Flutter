import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlackoutNotifier extends ChangeNotifier {
  final blackout = '';

  void changeBlackout(String selected) {
    blackout == selected;
    notifyListeners();
  }
}
