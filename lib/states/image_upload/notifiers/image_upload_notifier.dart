import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/constants/firebse_collection_name.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/constants/constants.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/exception/could_not_build_thumpnail_exception.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/extentions/get_collection_name_from_file_type.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/extentions/get_image_data_aspect_ratio.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/file_type.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/typedef/is_loading.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/models/post_settings.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post_payload.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/user_id.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSettings, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8list;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8list = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        thumbnailUint8list = thumb;

        break;
    }
    //ASPECT RATIO

    final thumbnailAspectRatio = await thumbnailUint8list.getAspectRatio();

    // CALCULATE REFERENCES
    final fileName = const Uuid().v4();

    //CREATE REFERENCES TO THUMBNAIL AND IMAGE ITSELF

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);
    try {
      //UPLOAD THUMBNAIL
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8list);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      //UPLOAD ORIGINAL FILE

      final originalUploadTask = await originalFileRef.putFile(file);
      final originalStorageId = originalUploadTask.ref.name;

      //UPLOAD THE POST IT SELF

      final postPayload = PostPayload(
          userId: userId,
          message: message,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          fileUrl: await originalFileRef.getDownloadURL(),
          fileType: fileType,
          fileName: fileName,
          aspectRatio: thumbnailAspectRatio,
          thumbnailStorageId: thumbnailStorageId,
          originalStorageId: originalStorageId,
          postSettings: postSettings);

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
