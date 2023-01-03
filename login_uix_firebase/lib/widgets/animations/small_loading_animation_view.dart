import 'package:login_uix_firebase/widgets/animations/lottie_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/models/lottie_animation.dart';

class SmallLoadingAnimationView extends LottieAnimationView {
  const SmallLoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.smallLoading,
        );
}
