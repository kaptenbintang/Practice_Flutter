import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin.dart';

import '../helper/local_navigator.dart';

class MediumAdminDashboard extends StatelessWidget {
  const MediumAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SideBarAdmin()),
        Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: adminDashboardNavigator(),
            ))
      ],
    );
  }
}
