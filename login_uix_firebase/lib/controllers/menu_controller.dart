import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = LandingRoute.obs;
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
      case LandingRoute:
        return _customIcon(Icons.home, itemName);
      case StartNowRoute:
        return _customIcon(Icons.star, itemName);
      case EventsRoute:
        return _customIcon(Icons.event, itemName);
      case LoginRoute:
        return _customIcon(Icons.person, itemName);
      case RegisterRoute:
        return _customIcon(Icons.app_registration_sharp, itemName);
      default:
        return _customIcon(Icons.home, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: dark,
      );
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
