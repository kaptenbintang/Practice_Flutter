import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesChangeProvider = StateProvider<bool?>((ref) => false);

final dateChangeProvider = StateProvider<bool?>((ref) => false);

final timeChangeProvider = StateProvider<bool?>((ref) => false);
