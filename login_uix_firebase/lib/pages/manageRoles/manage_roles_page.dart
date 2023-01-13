// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/pages/manageRoles/manage_roles_desktop.dart';
import 'package:login_uix_firebase/pages/manageRoles/manage_roles_mobile.dart';
import '../../helper/responsive.dart';

class ManageRolesPage extends StatefulWidget {
  const ManageRolesPage({super.key});

  @override
  State<ManageRolesPage> createState() => _ManageRolesPageState();
}

class _ManageRolesPageState extends State<ManageRolesPage> {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ManageRolesDesktop();
    } else {
      return ManageRolesMobile();
    }
  }
}
