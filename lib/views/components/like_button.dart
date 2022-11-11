import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/likes/model/like_dislike_request.dart';
import 'package:instagram_clone_vandad_yt/states/likes/provider/has_liked_post_provider.dart';
import 'package:instagram_clone_vandad_yt/states/likes/provider/like_dislike_post_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));

    return hasLiked.when(
      data: (hasLiked) => IconButton(
        icon: FaIcon(
          hasLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        ),
        onPressed: () {
          final userId = ref.read(userIdProvider);
          if (userId == null) return;
          final likeRequest = LikeDisLikeRequest(
            postId: postId,
            userId: userId,
          );
          ref.read(
            likeDislikePostProvider(
              likeRequest,
            ),
          );
        },
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
