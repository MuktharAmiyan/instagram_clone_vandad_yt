import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/auth/provider/user_id_provider.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';

final hasLikedPostProvider = StreamProvider.family.autoDispose<bool, PostId>((
  ref,
  PostId postId,
) {
  final userId = ref.read(userIdProvider);
  if (userId == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  // controller.onListen = () {
  //   controller.sink.add(false);
  // };
  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.likes,
      )
      .where(
        FirebaseFieldName.postId,
        isEqualTo: postId,
      )
      .where(
        FirebaseFieldName.userId,
        isEqualTo: userId,
      )
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      controller.add(true);
    } else {
      controller.add(false);
    }
    // controller.sink.add(
    //   snapshot.docs.isNotEmpty,
    // );
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
