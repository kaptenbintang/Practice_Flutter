import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/pages/dashboard_page.dart';
import 'package:login_uix_firebase/pages/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/user_table_page.dart';
import 'package:login_uix_firebase/widgets/drawer_header.dart';

import 'drawer_list_item.dart';

class DrawerDashBoard extends StatefulWidget {
  const DrawerDashBoard({super.key});

  @override
  State<DrawerDashBoard> createState() => _DrawerDashBoardState();
}

class _DrawerDashBoardState extends State<DrawerDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.book_outlined,
            text: 'Staff Table',
            onTap: () => Navigator.pushNamed(context, DashboardPage.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.verified_user,
            text: 'Client Table',
            onTap: () => Navigator.pushNamed(context, UserTablePage.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.verified_user,
            text: 'Manage Roles',
            onTap: () => Navigator.pushNamed(context, ManageRoles.routeName),
          ),
        ],
      ),
    );
  }
}
