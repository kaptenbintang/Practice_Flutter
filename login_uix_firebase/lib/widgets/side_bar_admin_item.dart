import 'package:flutter/material.dart';
import 'package:login_uix_firebase/widgets/horizontal_side_bar_admin_item.dart';
import 'package:login_uix_firebase/widgets/vertical_side_bar_admin_item.dart';

import '../helper/responsive.dart';

class SideBarAdminItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const SideBarAdminItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalSideAdminItem(
        itemName: itemName,
        onTap: onTap,
      );
    }

    return HorizontalAdminBarItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}

class SideBarPractionerItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const SideBarPractionerItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalSideAdminItem(
        itemName: itemName,
        onTap: onTap,
      );
    }

    return HorizontalAdminBarItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
