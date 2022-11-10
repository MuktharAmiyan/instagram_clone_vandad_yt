import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';

final postLikeCountProvider = StreamProvider.family.autoDispose<int, PostId>((
  ref,
  PostId postId,
) {
  final controller = StreamController<int>();
  controller.onListen = () {
    controller.sink.add(0);
  };
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: postId,
      )
      .snapshots()
      .listen((snapshot) {
    final length = snapshot.docs.length;
    controller.sink.add(length);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
