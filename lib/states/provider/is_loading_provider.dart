import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/auth_state_notifier.dart';
import 'package:instagram_clone_vandad_yt/states/comments/provider/delete_comment_provider.dart';
import 'package:instagram_clone_vandad_yt/states/comments/provider/send_comment_provider.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/providers/image_upload_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/delete_post_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final imageUpload = ref.watch(imageUploadProvider);
  final deleteComment = ref.watch(deleteCommentProvider);
  final sendComment = ref.watch(sendCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  return authState.isLoading ||
      imageUpload ||
      deleteComment ||
      sendComment ||
      isDeletingPost;
});
