import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;
import 'package:login_uix_firebase/auth/models/auth_state.dart';
import 'package:login_uix_firebase/auth/notifiers/auth_state_notifier.dart';

//provide authstate newest state
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
