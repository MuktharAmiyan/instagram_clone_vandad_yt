import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_vandad_yt/states/posts/model/post.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/error_animation_view.dart';
import 'package:video_player/video_player.dart';

class PostVideoview extends HookWidget {
  final Post post;
  const PostVideoview({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.network(post.fileUrl);
    final isVideoPlyerIsReady = useState(false);
    useEffect(() {
      controller.initialize().then((value) {
        isVideoPlyerIsReady.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, [controller]);
    switch (isVideoPlyerIsReady.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        return const ErrorAnimationView();
    }
  }
}
