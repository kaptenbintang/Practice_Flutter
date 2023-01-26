// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin.dart';

import '../auth/provider/user_id_provider.dart';
import '../helper/local_navigator.dart';
import '../user_info/providers/user_info_model_provider.dart';
import 'animations/error_animation_view.dart';
import 'animations/loading_animation_view.dart';

class LargeAdminDashboard extends StatelessWidget {
  final String roles;

  const LargeAdminDashboard({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: SideBarAdmin()),
        Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: (roles != 'practioner')
                  ? adminDashboardNavigator()
                  : practionerDashboardNavigator(),
            ))
      ],
    );
  }
}
