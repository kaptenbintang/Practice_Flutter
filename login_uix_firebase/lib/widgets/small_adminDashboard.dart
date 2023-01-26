import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/helper/local_navigator.dart';

class SmallAdminDashboard extends StatelessWidget {
  final String roles;
  const SmallAdminDashboard({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width16),
        child: (roles != 'practioner')
            ? adminDashboardNavigator()
            : practionerDashboardNavigator(),
      ),
    );
  }
}
