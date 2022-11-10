import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/states/comments/typedefs/comment_id.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/user_id.dart';

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createAt;
  final UserId fromUserId;
  final PostId postId;
  Comment(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldName.comment],
        createAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId],
        postId = json[FirebaseFieldName.postId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createAt == other.createAt &&
          fromUserId == other.fromUserId &&
          postId == other.postId;

  @override
  int get hashCode => Object.hashAll([
        id,
        comment,
        createAt,
        postId,
        fromUserId,
      ]);
}
