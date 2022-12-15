import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/roles_get_provider.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';

final checkCurrentUserRolesProvider =
    StreamProvider.autoDispose.family<bool, String>((ref, String can) async* {
  final dsda = ref.watch(getRolesPrivProvider).value as Map<String, dynamic>;

  if (can == "canDelete") {
    // final bool ee = dsda['canDelete'];
    yield dsda['canDelete'] as bool;
  } else if (can == 'canRead') {
    yield dsda['canRead'] as bool;
  } else if (can == 'canWrite') {
    yield dsda['canWrite'] as bool;
  } else {
    yield dsda['canWriteAll'] as bool;
  }
});
