import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_profile_desktop_riverpod.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_profile_mobile_riverpod.dart';

import '../../helper/responsive.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return EditProfileMobileWidgetRiverpod();
    } else {
      return EditProfileDesktopWidget2();
    }
  }
}
