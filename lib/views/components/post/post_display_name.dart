import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/states/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/rich_text/rich_two_parts_text.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));
    return userInfoModel.when(
      data: (user) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTwoPart(
          leftPart: user.displayName,
          rightPart: post.message,
        ),
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
