import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/comments/extension/comment_sorting_by_request.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_comment_request.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';

final postCommentProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snapShot) {
    final document = snapShot.docs;
    final limitDocuments =
        request.limit != null ? document.take(request.limit!) : document;
    final comment = limitDocuments
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((doc) {
      final id = doc.id;
      final json = doc.data();
      return Comment(json, id: id);
    });
    final result = comment.applySortingFrom(request);
    controller.sink.add(result);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
