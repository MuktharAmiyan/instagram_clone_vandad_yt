import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/all_post_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_grid_view.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(allPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          }
          return PostGridView(posts: posts);
        },
        error: ((error, stackTrace) => const ErrorAnimationView()),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
