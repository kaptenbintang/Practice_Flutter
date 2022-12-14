// @riverpod
// bool isLoading(IsLoadingRef ref) {
//   final authState = ref.watch(authStateProvider);
//   final isUploadingImage = ref.watch(imageUploaderProvider);
//   final isSendingComment = ref.watch(sendCommentProvider);
//   final isDeletingComment = ref.watch(deleteCommentProvider);
//   final isDeletingPost = ref.watch(deletePostProvider);
//   return authState.isLoading ||
//       isUploadingImage ||
//       isSendingComment ||
//       isDeletingComment ||
//       isDeletingPost;
// }
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/edit_user_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isEditProfile = ref.watch(editUserProvider);
  return authState.isLoading || isEditProfile;
});
