import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;
import 'package:login_uix_firebase/model/auth/auth_state.dart';
import 'package:login_uix_firebase/provider/login_page/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
