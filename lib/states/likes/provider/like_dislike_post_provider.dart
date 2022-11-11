import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/likes/model/like.dart';
import 'package:instagram_clone_vandad_yt/states/likes/model/like_dislike_request.dart';

final likeDislikePostProvider = FutureProvider.family
    .autoDispose<bool, LikeDisLikeRequest>(
        (ref, LikeDisLikeRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .where(
        FirebaseFieldName.userId,
        isEqualTo: request.userId,
      )
      .get();
  //FIRST CHECK IS lIKED
  final hasLiked = await query.then(
    (snapshot) => snapshot.docs.isNotEmpty,
  );
  if (hasLiked) {
    //DELETE THE LIKE
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    //POST LIKE OBJECT
    final like = Like(
      postId: request.postId,
      likedBy: request.userId,
      date: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(
            like,
          );
      return true;
    } catch (_) {
      return false;
    }
  }
});
