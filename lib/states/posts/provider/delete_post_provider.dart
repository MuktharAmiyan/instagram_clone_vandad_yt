import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/typedef/is_loading.dart';
import 'package:instagram_clone_vandad_yt/states/posts/notifier/delete_post_state_notifier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
  (_) => DeletePostStateNotifier(),
);
