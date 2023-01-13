import 'package:hooks_riverpod/hooks_riverpod.dart';

//change string location
class LocationNotifier extends StateNotifier<String> {
  LocationNotifier() : super('sasa');

  void changeLocation(String location) {
    state = location;
  }
}
