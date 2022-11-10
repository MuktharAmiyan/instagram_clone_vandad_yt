import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/likes/provider/post_like_count_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/constants/strings.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeCount = ref.watch(postLikeCountProvider(postId));
    return likeCount.when(
        data: (likeCount) {
          final isPersonorPeople =
              likeCount == 1 ? Strings.person : Strings.people;
          return Text('$likeCount $isPersonorPeople ${Strings.likedThis}');
        },
        error: (error, stackTrace) => const SmallErrorAnimationView(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
