import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/auth/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}
