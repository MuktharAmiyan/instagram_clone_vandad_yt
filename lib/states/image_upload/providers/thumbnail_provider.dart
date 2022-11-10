import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/exception/could_not_build_thumpnail_exception.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/extentions/get_image_aspect_ratio.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/file_type.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>((
  ref,
  ThumbnailRequest request,
) async {
  final Image image;
  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final thump = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thump == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thump,
        fit: BoxFit.fitHeight,
      );
      break;
  }
  final aspectRatio = await image.getAspectRatio();
  return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
});
