import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';

final canCurrentUserDeleteProvider = StreamProvider.family<bool, Post>((
  ref,
  Post post,
) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
