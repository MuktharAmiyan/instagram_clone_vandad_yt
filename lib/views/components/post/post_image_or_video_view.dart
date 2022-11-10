import 'package:flutter/material.dart';
import 'package:instagram_clone_vandad_yt/states/image_upload/models/file_type.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_image_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(post: post);
      case FileType.video:
        return PostVideoview(post: post);

      default:
        return const SizedBox();
    }
  }
}
