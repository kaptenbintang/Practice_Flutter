import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';
import 'package:login_uix_firebase/provider/edit_practioner_state_notifier.dart';

import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';

//callback EditUserNotifier class

final editUserProvider = StateNotifierProvider<EditUserNotifier, IsLoading>(
  (ref) => EditUserNotifier(),
);
final editPractionerProvider =
    StateNotifierProvider<EditPractionerNotifier, IsLoading>(
  (ref) => EditPractionerNotifier(),
);
