import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/posts/provider/post_by_search_term_provider.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/search_term.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/data_not_found_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/posts_sliver_grid_view.dart';
import 'package:instagram_clone_vandad_yt/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
            text: Strings.enterYourSearchTerm),
      );
    }
    final posts = ref.watch(postsBySrearchTermProvider(searchTerm));
    return posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const SliverToBoxAdapter(child: DataNotFoundAnimationView());
          }
          return PostSliverGridView(posts: posts);
        },
        error: ((error, stackTrace) =>
            const SliverToBoxAdapter(child: ErrorAnimationView())),
        loading: () => const SliverToBoxAdapter(child: LoadingAnimationView()));
  }
}
