// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/pages/manageServicesCategory/manage_service_category_desktop.dart';
import 'package:login_uix_firebase/pages/manageServicesCategory/manage_service_category_mobile.dart';
import '../../helper/responsive.dart';

class ManageServiceCategoryPage extends StatefulWidget {
  const ManageServiceCategoryPage({super.key});

  @override
  State<ManageServiceCategoryPage> createState() =>
      _ManageServiceCategoryPageState();
}

class _ManageServiceCategoryPageState extends State<ManageServiceCategoryPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageServiceCategoryDesktop();
    } else {
      return ManageServiceCategoryMobile();
    }
  }
}
