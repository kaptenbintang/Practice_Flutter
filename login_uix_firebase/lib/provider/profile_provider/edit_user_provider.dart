import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:login_uix_firebase/provider/profile_notifier/edit_user_state_notifier.dart';

final editUserProvider = StateNotifierProvider<EditUserNotifier, bool>(
  (ref) => EditUserNotifier(),
);
