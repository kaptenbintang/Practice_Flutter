import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/user_data.dart';
import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';

final editUserProvider = StateNotifierProvider<EditUserNotifier, UserData?>(
  (ref) => EditUserNotifier(),
);
