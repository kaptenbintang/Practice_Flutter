import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:login_uix_firebase/provider/specialdate_provider/specialdate_notifier.dart';

//callback  changeSpecialDate class

final editSpecialDateProvider =
    StateNotifierProvider<ChangeSpecialDate, IsLoading>(
  (ref) => ChangeSpecialDate(),
);

//callback  changeDescriptionDayoff class

final editDescriptionDayoffProvider =
    StateNotifierProvider<ChangeDescriptionDayoff, IsLoading>(
  (ref) => ChangeDescriptionDayoff(),
);

//callback  deleteSpecialDate class

final deleteSpecialDateProvider =
    StateNotifierProvider<DeleteSpecialDate, IsLoading>(
  (ref) => DeleteSpecialDate(),
);
