import 'package:login_uix_firebase/widgets/animations/lottie_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/models/lottie_animation.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
          reverse: true,
        );
}
