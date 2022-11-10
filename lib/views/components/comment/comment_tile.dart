import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/comments/provider/delete_comment_provider.dart';
import 'package:instagram_clone_vandad_yt/states/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/constants/strings.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/alert_dialog_model.dart';
import 'package:instagram_clone_vandad_yt/views/components/dialog/delete_dialog.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userInfoModelProvider(comment.fromUserId));

    return user.when(
      data: (userInfo) {
        final curentUserId = ref.read(userIdProvider);
        return ListTile(
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
          trailing: curentUserId == userInfo.userId
              ? IconButton(
                  onPressed: () async {
                    final shoudlBeDeleted = await displayDeleteDialog(context);

                    if (shoudlBeDeleted) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(
                            commentId: comment.id,
                          );
                    }
                  },
                  icon: const Icon(Icons.delete))
              : null,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) =>
      DeleteDialog(titleOfObject: Strings.comment).present(context).then(
            (value) => value ?? false,
          );
}
