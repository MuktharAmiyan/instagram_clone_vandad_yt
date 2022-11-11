import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/comments/extension/comment_sorting_by_request.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/comment.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_comment_request.dart';
import 'package:instagram_clone_vandad_yt/states/comments/model/post_with_comment.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';

final specificPostWithCommentsProviderProvider = StreamProvider.family
    .autoDispose<PostWithComment, RequestForPostAndComments>((
  ref,
  RequestForPostAndComments request,
) {
  final controller = StreamController<PostWithComment>();
  Post? post;
  Iterable<Comment>? comments;
  void notify() {
    final localPost = post;
    if (localPost == null) return;
    final outputComments = (comments ?? []).applySortingFrom(
      request,
    );
    final result = PostWithComment(
      post: localPost,
      comment: outputComments,
    );
    controller.sink.add(result);
  }

  final postSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .where(FieldPath.documentId, isEqualTo: request.postId)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isEmpty) {
      post = null;
      comments = null;
      notify();
      return;
    }
    final doc = snapshot.docs.first;
    if (doc.metadata.hasPendingWrites) return;
    final id = doc.id;
    final json = doc.data();
    post = Post(
      postId: id,
      json: json,
    );
    notify();
  });
  final commentQuery = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      );

  final limitedCommentsQuery = request.limit != null
      ? commentQuery.limit(
          request.limit!,
        )
      : commentQuery;

  final commentSub = limitedCommentsQuery.snapshots().listen(
    (snapsot) {
      comments = snapsot.docs
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((doc) => Comment(
                doc.data(),
                id: doc.id,
              ))
          .toList();
      notify();
    },
  );
  ref.onDispose(() {
    postSub.cancel();
    commentSub.cancel();
    controller.close();
  });
  return controller.stream;
});
