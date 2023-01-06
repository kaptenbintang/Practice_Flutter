import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/appointment_upload_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/edit_user_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isEditProfile = ref.watch(editUserProvider);
  final uploadAppointment = ref.watch(appointmentUploaderProvider);
  return authState.isLoading || isEditProfile || uploadAppointment;
});
