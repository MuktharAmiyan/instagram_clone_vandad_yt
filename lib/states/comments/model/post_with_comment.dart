import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';

@immutable
class PostWithComment {
  final Post post;
  final Iterable<Comment> comment;

  const PostWithComment({
    required this.post,
    required this.comment,
  });

  @override
  bool operator ==(covariant PostWithComment other) =>
      post == other.post &&
      const IterableEquality().equals(
        comment,
        other.comment,
      );

  @override
  int get hashCode => Object.hashAll([
        post,
        comment,
      ]);
}
