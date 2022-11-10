import 'package:instagram_clone_vandad_yt/enum/date_sorting.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_comment_request.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostAndComments request) {
    if (request.sortedByCreatedAt) {
      final sortedDocuments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case DateSorting.newestOnTop:
              return b.createAt.compareTo(a.createAt);

            case DateSorting.oldestOnTop:
              return a.createAt.compareTo(b.createAt);
          }
        });
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
