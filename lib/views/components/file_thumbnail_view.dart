import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/image_with_aspect_ratio.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/providers/thumbnail_provider.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/loading_animation_view.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
        data: (imageWithAspectRatio) => AspectRatio(
              aspectRatio: imageWithAspectRatio.aspectRatio,
              child: imageWithAspectRatio.image,
            ),
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView());
  }
}