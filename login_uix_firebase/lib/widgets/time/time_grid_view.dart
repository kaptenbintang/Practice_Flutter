import 'package:flutter/material.dart';
import 'package:login_uix_firebase/widgets/time/time_thumbnail_view.dart';

class TimesGridView extends StatelessWidget {
  final String serviceTime;
  final Map schedule;
  const TimesGridView(
      {super.key, required this.serviceTime, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final intValue = int.parse(serviceTime.replaceAll(RegExp('[^0-9]'), ''));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        // return TimesThumbnailView(practioner: practioner, onTapped: onTapped);
      },
    );
  }
}
