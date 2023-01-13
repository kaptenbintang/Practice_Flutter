import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/helper/responsive.dart';
import 'package:login_uix_firebase/routing/routes.dart';

class SideBarAdminController extends GetxController {
  static SideBarAdminController instance = Get.find();
  var activeItem = ManageStaffRoute.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case ManageStaffRoute:
        return _customIcon(Icons.star, itemName);
      case ManageClientRoute:
        return _customIcon(Icons.person, itemName);
      case ManageRolesRoute:
        return _customIcon(Icons.rule, itemName);
      case ManageClientTypeRoute:
        return _customIcon(Icons.assignment_ind, itemName);
      case ManageServicesRoute:
        return _customIcon(Icons.home_repair_service, itemName);
      case ManageServicesCategoryRoute:
        return _customIcon(Icons.content_paste, itemName);
      case AppointmentRoute:
        return _customIcon(Icons.calendar_month, itemName);
      case LogOutRoute:
        return _customIcon(Icons.logout, itemName);
      default:
        return _customIcon(Icons.star, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: ResponsiveWidget.isSmallScreen(Get.context!)
            ? Dimensions.font12 * 2
            : 24,
        color: FlutterFlowTheme.of(Get.context!).primaryColor,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName)
          ? FlutterFlowTheme.of(Get.context!).primaryColor
          : FlutterFlowTheme.of(Get.context!).primaryText,
    );
  }
}
