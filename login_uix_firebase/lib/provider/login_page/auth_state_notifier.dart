import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/authenticator.dart';
import 'package:login_uix_firebase/auth/models/auth_result.dart';
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/user_info/backend/user_info_storage.dart';

import 'package:login_uix_firebase/model/auth/user_id.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithEmailPassword(String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithEmailPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> createdWithEmailPassword(String email, String password) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.createWithEmailandPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(
        userId: userId,
      );
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        firstName: '',
        lastName: 'lastName',
        clientcode: 'clientcode',
        createdAt: 'createdAt',
        email: _authenticator.email,
        phoneNumber: 'phoneNumber',
        roles: 'roles',
        markDeleted: false,
        clientType: 'clientType',
        dateofbirth: 'dateofbirth',
      );
}
