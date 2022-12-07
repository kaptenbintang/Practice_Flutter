// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/widgets/horizontol_menu_item.dart';
import 'package:login_uix_firebase/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const SideMenuItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }

    return HorizontolMenuItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
