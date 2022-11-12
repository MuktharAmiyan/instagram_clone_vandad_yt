import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/search_term.dart';

final postsBySrearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>((
  ref,
  SearchTerm searchTerm,
) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .snapshots()
      .listen((snapsot) {
    final posts = snapsot.docs
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        )
        .where(
          (post) => post.message.toLowerCase().contains(
                searchTerm.toLowerCase(),
              ),
        );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
