import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/practioner_models/practioner.dart';
import 'package:login_uix_firebase/pages/detailPractionerPage/detail_practioner_page.dart';
import 'package:login_uix_firebase/widgets/practioners/practioners_thumbnail_view.dart';

import '../../helper/responsive.dart';

class PractionersGridView extends StatelessWidget {
  final Iterable<Practioner> practioners;

  const PractionersGridView({
    Key? key,
    required this.practioners,
  }) : super(key: key);

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
    return SizedBox(
      height: ResponsiveWidget.isLargeScreen(context)
          ? screenWidth / (width / 430)
          : screenWidth / (width / 380),
      width: double.maxFinite,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveWidget.isLargeScreen(context) ? 3 : 1,
          mainAxisSpacing: ResponsiveWidget.isLargeScreen(context)
              ? screenWidth / (width / 300)
              : screenWidth / (width / 50),
          crossAxisSpacing: ResponsiveWidget.isLargeScreen(context)
              ? screenWidth / (width / 300)
              : screenWidth / (width / 600),
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
      ),
    );
  }
}
