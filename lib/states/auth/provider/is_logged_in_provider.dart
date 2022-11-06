import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/models/auth_result.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(
    authStateProvider,
  );
  return authState.result == AuthResult.success;
});
