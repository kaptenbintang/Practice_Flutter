import 'package:hooks_riverpod/hooks_riverpod.dart';

//change service value
class ServicesNotifier extends StateNotifier<String> {
  ServicesNotifier() : super('');

  void selectedService(String service) {
    state = service;
  }
}
