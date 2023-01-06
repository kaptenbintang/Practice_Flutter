import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/provider/appointment_page/time_loop_provider.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        final timeLoop = ref.watch(timeLoopProvider(Parameters(
            schedules: schedule,
            serviceTipe: serviceTime,
            dateSelected: selectedTime)));
        return timeLoop.when(
          data: (data) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 500,
                crossAxisSpacing: 100,
                childAspectRatio: 1,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final oneItem = data.elementAt(index);
                return TimesThumbnailView(
                  serviceTime: oneItem,
                  onTapped: () {},
                );
                // return TimesThumbnailView(practioner: practioner, onTapped: onTapped);
              },
            );
          },
          error: (error, stackTrace) {
            print(error);
            return SmallErrorAnimationView();
          },
          loading: () {
            return SmallLoadingAnimationView();
          },
        );
        // return GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 4,
        //     mainAxisSpacing: 2.0,
        //     crossAxisSpacing: 5.0,
        //     childAspectRatio: 1,
        //   ),
        //   itemCount: timeLoop.length,
        //   itemBuilder: (context, index) {
        //     final oneItem = timeLoop.elementAt(index);
        //     return TimesThumbnailView(
        //       serviceTime: oneItem,
        //       onTapped: () {},
        //     );
        //     // return TimesThumbnailView(practioner: practioner, onTapped: onTapped);
        //   },
        // );
      },
    );
  }
}
