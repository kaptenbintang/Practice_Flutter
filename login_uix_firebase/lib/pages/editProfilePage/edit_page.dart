import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_profile_desktop.dart';
import 'package:login_uix_firebase/pages/editProfilePage/edit_profile_mobile.dart';

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
      return EditProfileMobileWidget();
    } else {
      return EditProfileDesktopWidget();
    }
  }
}