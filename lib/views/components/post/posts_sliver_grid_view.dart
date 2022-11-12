import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone_vandad_yt/views/post_details/post_details_view.dart';

class PostSliverGridView extends ConsumerWidget {
  final Iterable<Post> posts;
  const PostSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate:
          SliverChildBuilderDelegate(childCount: posts.length, (_, index) {
        final post = posts.elementAt(index);
        return PostThumbailView(
          post: post,
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsView(post: post),
              ),
            );
          },
        );
      }),
    );
  }
}
