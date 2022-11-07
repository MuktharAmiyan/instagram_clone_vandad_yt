import 'package:instagram_clone_vandad_yt/views/components/animation/lottie_animation_view.dart';
import 'package:instagram_clone_vandad_yt/views/components/animation/models/lottie_animation.dart';

class EmptyContentAnimationView extends LottieAnimationView {
  const EmptyContentAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
