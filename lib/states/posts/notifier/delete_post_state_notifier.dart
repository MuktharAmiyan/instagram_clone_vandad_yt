import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebase_field_name.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/extentions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/typedef/is_loading.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/post_id.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading> {
  DeletePostStateNotifier() : super(false);
  set isloading(bool value) => state = value;

  Future<bool> deletePost({required Post post}) async {
    try {
      isloading = true;
      //delete Post thumnail from storage
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.tumbnailStorageId)
          .delete();

      //DELTE ORIGINAL POST FROM STORGAE
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete();
      //DELETE ALL COMMENTS ASSOCIATE WITH THIS POST

      await _deleteAllDocuments(
        postId: post.postId,
        inCollection: FirebaseCollectionName.comments,
      );

      //DELETE ALL LIKES FRON FIRESTORE
      await _deleteAllDocuments(
        postId: post.postId,
        inCollection: FirebaseCollectionName.likes,
      );

      // DELETE POST ITSELF

      final postInCollection = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.posts,
          )
          .where(
            FieldPath.documentId,
            isEqualTo: post.postId,
          )
          .limit(1)
          .get();
      for (var post in postInCollection.docs) {
        await post.reference.delete();
      }
      return true;
    } catch (_) {
      return false;
    } finally {
      isloading = false;
    }
  }

  Future<void> _deleteAllDocuments(
      {required PostId postId, required String inCollection}) async {
    return FirebaseFirestore.instance.runTransaction(
        maxAttempts: 3,
        timeout: const Duration(seconds: 20), (transaction) async {
      final query = await FirebaseFirestore.instance
          .collection(inCollection)
          .where(
            FirebaseFieldName.postId,
            isEqualTo: postId,
          )
          .get();
      for (var doc in query.docs) {
        doc.reference.delete();
      }
    });
  }
}
