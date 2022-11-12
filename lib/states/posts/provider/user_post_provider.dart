import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post_key.dart';

final userPostProvider = StreamProvider.autoDispose<Iterable<Post>>((
  ref,
) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Post>>();
  controller.onListen = () {
    controller.sink.add([]);
  };
  // final Iterable<String> list = [
  //   "9l8o7rLWnbNNfah8NNPROFgxVcu2",
  //   //"SAxNW43hSXYaa29dRAazn3b5PUa2",
  // ];

  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .where(
        PostKey.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen((snapshot) {
    final document = snapshot.docs;
    final post = document
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        );
    // .where((post) => list.any((uid) => uid == post.userId));

    controller.add(post);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
