import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'blackout_notifier.dart';

//provide bool edit status day name value
final editStatusDayName =
    StateNotifierProvider<ChangeStatusDayNameNotifier, IsLoading>(
  (ref) => ChangeStatusDayNameNotifier(),
);
