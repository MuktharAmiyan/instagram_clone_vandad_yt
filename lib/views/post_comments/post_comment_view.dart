import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_comment_request.dart';
import 'package:instagram_clone_vandad_yt/states/comments/provider/post_comment_provider.dart';
import 'package:instagram_clone_vandad_yt/states/comments/provider/send_comment_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/comment/comment_tile.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_vandad_yt/views/extension/dismiss_keyboard.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(
      RequestForPostAndComments(
        postId: postId,
      ),
    );
    final comments = ref.watch(
      postCommentProvider(
        request.value,
      ),
    );
    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(
                      commentController,
                      ref,
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const SingleChildScrollView(
                      child: EmptyContentsWithTextAnimationView(
                          text: Strings.noCommentsYet),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () {
                      // ignore: unused_result
                      ref.refresh(postCommentProvider(request.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: comments.length,
                      itemBuilder: (_, index) => CommentTile(
                        comment: comments.elementAt(index),
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => const ErrorAnimationView(),
                loading: () => const LoadingAnimationView(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: TextField(
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(
                          commentController,
                          ref,
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController commentController,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId != null) {
      final isSent = await ref
          .read(
            sendCommentProvider.notifier,
          )
          .sendComment(
            fromUserId: userId,
            onPostId: postId,
            comment: commentController.text,
          );
      if (isSent) {
        commentController.clear();
        dismissKeyboard();
      }
    }
  }
}
