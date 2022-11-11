import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/rich_text/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
        data: (userInfo) => RichTwoPart(
              leftPart: userInfo.displayName,
              rightPart: comment.comment,
            ),
        error: (error, stackTrace) => const SmallErrorAnimationView(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
