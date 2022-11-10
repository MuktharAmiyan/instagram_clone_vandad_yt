import 'package:flutter/foundation.dart' show immutable;

import 'package:instagram_clone_vandad_yt/enum/date_sorting.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';

@immutable
class RequestForPostAndComments {
  final PostId postId;
  final bool sortedByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;
  const RequestForPostAndComments({
    required this.postId,
    this.sortedByCreatedAt = true,
    this.dateSorting = DateSorting.newestOnTop,
    this.limit,
  });

  @override
  bool operator ==(covariant RequestForPostAndComments other) =>
      postId == other.postId &&
      sortedByCreatedAt == other.sortedByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;

  @override
  int get hashCode => Object.hashAll([
        postId,
        sortedByCreatedAt,
        dateSorting,
        limit,
      ]);
}
