import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/user_id.dart';

final userIdProvider = Provider<UserId?>(
  (ref) => ref
      .watch(
        authStateProvider,
      )
      .userId,
);
