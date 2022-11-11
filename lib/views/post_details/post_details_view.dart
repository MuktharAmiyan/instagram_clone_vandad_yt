import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/enum/date_sorting.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_comment_request.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/can_current_user_delete_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/delete_post_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/specific_post_with_comments_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/comment/compact_comment_column.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/alert_dialog_model.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/delete_dialog.dart';
import 'package:instagram_clone_vandad_yt/views/components/like_button.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/likes_count_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_date_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_display_name.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_image_or_video_view.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/post_comments/post_comment_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      sortedByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
      limit: 3,
    );
    final postWithComment = ref.watch(
      specificPostWithCommentsProviderProvider(
        request,
      ),
    );
    final canDeltePost = ref.watch(
      canCurrentUserDeleteProvider(
        widget.post,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          postWithComment.when(
            data: (postWithComment) => IconButton(
              onPressed: () async {
                final url = postWithComment.post.fileUrl;
                await Share.share(
                  url,
                  subject: Strings.checkOutThisPost,
                );
              },
              icon: const Icon(
                Icons.share,
              ),
            ),
            error: (
              error,
              stackTrace,
            ) =>
                const SmallErrorAnimationView(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          //DELETE BUTTON FOR ONLY CURRENT USER
          if (canDeltePost.value ?? false)
            IconButton(
              onPressed: () async {
                final shouldDeletePost =
                    await DeleteDialog(titleOfObject: Strings.post)
                        .present(context)
                        .then((shouldDelete) => shouldDelete ?? false);

                if (shouldDeletePost) {
                  await ref
                      .read(
                        deletePostProvider.notifier,
                      )
                      .deletePost(
                        post: widget.post,
                      );
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: postWithComment.when(
        data: (postWithComment) {
          final postId = postWithComment.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImageOrVideoView(post: postWithComment.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComment.post.allowLikes)
                      LikeButton(postId: postId),
                    if (postWithComment.post.allowComments)
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostCommentView(postId: postId),
                            ),
                          );
                        },
                        icon: const Icon(Icons.mode_comment_outlined),
                      ),
                  ],
                ),
                PostDisplayNameAndMessageView(post: postWithComment.post),
                PostDateView(dateTime: postWithComment.post.createdAt),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CombactCommentColumn(comments: postWithComment.comment),
                if (postWithComment.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(postId: postId),
                      ],
                    ),
                  ),
                // ADD SPACING BOTTOM OF SCREEN
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
