import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/widgets/custom_text.dart';

// ignore: must_be_immutable
class HorizontolMenuItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  HorizontolMenuItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName!)
            : menuController.onHover("not hovering");
      },
      child: Obx((() => Container(
            color: menuController.isHovering(itemName!)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName!) ||
                      menuController.isActive(itemName!),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: dark,
                  ),
                ),
                SizedBox(
                  width: _width / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.returnIconFor(itemName!),
                ),
                (!menuController.isActive(itemName!))
                    ? Flexible(
                        child: CustomText(
                        text: itemName!,
                        color: menuController.isHovering(itemName!)
                            ? dark
                            : lightGrey,
                      ))
                    : Flexible(
                        child: CustomText(
                          text: itemName!,
                          color: dark,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                      )
              ],
            ),
          ))),
    );
  }
}
