import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/comments/notifiers/delete_comment_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/typedef/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifers, IsLoading>(
        (_) => DeleteCommentNotifers());
