import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/backend/authenticator.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/user_info/backend/user_info_storage.dart';

import 'package:login_uix_firebase/model/auth/user_id.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  // call authenticator class
  final _authenticator = const Authenticator();
  // call userinfostorage class
  final _userInfoStorage = const UserInfoStorage();

  /* state in here means AuthState */

  // AuthStateNotifier constructor
  // Set default state value and change default state value if a user login in
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

// Function for calling logout function on authenticator class and changing the state
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

// Function for calling login function on authenticator class and changing the state
  Future<void> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    // isLoading to true for show the loading animation
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.loginWithEmailPassword(email, password, context);
    final userId = _authenticator.userId;

    // update the state and isloading to false to dismiss the loading animation
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

// Function for calling register function on authenticator class and store all the value into Firestore using saveUserinfo function. Change state
  Future<void> createdWithEmailPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    String clientCode,
    String createdAt,
    String phoneNumber,
    String roles,
    bool markDeleted,
    String clientType,
    String dataofbirth,
  ) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.createWithEmailandPassword(
      email,
      password,
      firstName,
    );
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
        password: password,
        firstName: firstName,
        lastName: lastName,
        clientCode: clientCode,
        createdAt: createdAt,
        phoneNumber: phoneNumber,
        roles: roles,
        markDeleted: markDeleted,
        clientType: clientType,
        dataofbirth: dataofbirth,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

// Function for calling saveUserInfo function on userinfostorage class
  Future<void> saveUserInfo({
    required UserId userId,
    // String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? clientCode,
    String? createdAt,
    String? phoneNumber,
    String? roles,
    bool? markDeleted,
    String? clientType,
    String? dataofbirth,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        firstName: firstName!,
        lastName: lastName!,
        clientcode: clientCode!,
        createdAt: createdAt!,
        email: _authenticator.email,
        phoneNumber: phoneNumber!,
        roles: roles!,
        markDeleted: markDeleted!,
        clientType: clientType!,
        dateofbirth: dataofbirth!,
      );
}
