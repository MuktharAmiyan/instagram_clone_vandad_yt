import 'package:flutter/material.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/views/components/comment/compact_comment_title.dart';

class CombactCommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CombactCommentColumn({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        bottom: 8.0,
        right: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments
            .map(
              (comment) => CompactCommentTile(
                comment: comment,
              ),
            )
            .toList(),
      ),
    );
  }
}
