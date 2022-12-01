import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/pages/dashboard_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_client_type_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_roles_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_servicesCategory_page.dart';
import 'package:login_uix_firebase/pages/manage_tabledashboard/manage_services_page.dart';
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
            onTap: () => Navigator.pushReplacementNamed(
                context, DashboardPage.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.verified_user,
            text: 'Client Table',
            onTap: () => Navigator.pushReplacementNamed(
                context, UserTablePage.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.manage_accounts,
            text: 'Manage Roles',
            onTap: () =>
                Navigator.pushReplacementNamed(context, ManageRoles.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.manage_search,
            text: 'Manage Client Type',
            onTap: () => Navigator.pushReplacementNamed(
                context, ManageClients.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.medical_services,
            text: 'Manage Services',
            onTap: () => Navigator.pushReplacementNamed(
                context, ManageServices.routeName),
          ),
          createDrawerBodyItem(
            icon: Icons.category,
            text: 'Manage Services Category',
            onTap: () => Navigator.pushReplacementNamed(
                context, ManageServiceCategory.routeName),
          ),
        ],
      ),
    );
  }
}
