import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/user_post_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_grid_view.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          return posts.isEmpty
              ? const EmptyContentsWithTextAnimationView(
                  text: Strings.youHaveNoPosts,
                )
              : PostGridView(
                  posts: posts,
                );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
