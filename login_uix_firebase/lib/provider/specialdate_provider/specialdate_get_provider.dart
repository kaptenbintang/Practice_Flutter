import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';
import 'package:login_uix_firebase/provider/specialdate_provider/specialdate_notifier.dart';

final editSpecialDateProvider =
    StateNotifierProvider<changeSpecialDate, IsLoading>(
  (ref) => changeSpecialDate(),
);

final editDescriptionDayoffProvider =
    StateNotifierProvider<changeDescriptionDayoff, IsLoading>(
  (ref) => changeDescriptionDayoff(),
);

final deleteSpecialDateProvider =
    StateNotifierProvider<deleteSpecialDate, IsLoading>(
  (ref) => deleteSpecialDate(),
);
