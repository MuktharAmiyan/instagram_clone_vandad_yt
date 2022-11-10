import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_vandad_yt/states/image_upload/models/file_type.dart';
import 'package:instagram_clone_vandad_yt/states/post_settings/models/post_settings.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post_key.dart';
import 'package:instagram_clone_vandad_yt/states/posts/typedefs/user_id.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalStorageId,
    required Map<PostSettings, bool> postSettings,
  }) : super({
          PostKey.userId: userId,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.message: message,
          PostKey.thumbnailUrl: thumbnailUrl,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileType.name,
          PostKey.fileName: fileName,
          PostKey.aspectRatio: aspectRatio,
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.originalFileStorageId: originalStorageId,
          PostKey.postSettings: {
            for (final postsetting in postSettings.entries)
              postsetting.key.storageKey: postsetting.value,
          },
        });
}
