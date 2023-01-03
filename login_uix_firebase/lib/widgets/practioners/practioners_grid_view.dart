import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/pages/detail_practioner_page.dart';
import 'package:login_uix_firebase/widgets/practioners/practioners_thumbnail_view.dart';

class PractionersGridView extends StatelessWidget {
  final Iterable<Practioner> practioners;

  const PractionersGridView({
    Key? key,
    required this.practioners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1,
      ),
      itemCount: practioners.length,
      itemBuilder: (context, index) {
        final practioner = practioners.elementAt(index);
        return PractionersThumbnailView(
          practioner: practioner,
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPagePractioner(
                  practioner: practioner,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
