import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/model/time_models/time.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_loop_provider.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_selected_provider.dart';
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/small_loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/time/time_thumbnail_view.dart';

class TimesGridView extends StatelessWidget {
  final String serviceTime;
  final String selectedTime;
  final Map<dynamic, dynamic> schedule;
  const TimesGridView({
    super.key,
    required this.serviceTime,
    required this.schedule,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return Consumer(
      builder: (context, ref, child) {
        final timeLoop = ref.watch(timeLoopProvider(schedule));
        return timeLoop.when(
          data: (data) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveWidget.isLargeScreen(context) ? 8 : 3,
                mainAxisSpacing: screenWidth / (width / 10),
                crossAxisSpacing: screenWidth / (width / 10),
                childAspectRatio: 1,
              ),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                TimeModel oneItem = data.elementAt(index)!;
                return TimesThumbnailView(
                  serviceTime: oneItem,
                  onTapped: () {
                    oneItem.isSelected = !oneItem.isSelected;
                    ref
                        .read(timeSelectedProvider.notifier)
                        .selectedTime(oneItem.timeStamp);
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return SmallErrorAnimationView();
          },
          loading: () {
            return SmallLoadingAnimationView();
          },
        );
      },
    );
  }
}
