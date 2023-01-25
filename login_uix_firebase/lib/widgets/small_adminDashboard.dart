import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/helper/local_navigator.dart';

class SmallAdminDashboard extends StatelessWidget {
  const SmallAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width16),
        child: adminDashboardNavigator(),
      ),
    );
  }
}
