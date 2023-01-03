import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/style.dart';
import 'package:login_uix_firebase/controllers/side_bar_admin_controller.dart';
import 'package:login_uix_firebase/routing/routes.dart';
import 'package:login_uix_firebase/widgets/custom_text.dart';

import '../constant/controllers.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../helper/responsive.dart';

class HorizontalAdminBarItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const HorizontalAdminBarItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? sideAdminController.onHover(itemName!)
            : sideAdminController.onHover("not hovering");
      },
      child: Obx(() => Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0, _width / (maxWidth / 8), 0, 0),
            child: Container(
              width: double.infinity,
              height: _width / (maxWidth / 48),
              decoration: BoxDecoration(
                color: sideAdminController.isActive(itemName!)
                    ? FlutterFlowTheme.of(context).secondaryBackground
                    : sideAdminController.isHovering(itemName!)
                        ? lightGrey.withOpacity(.1)
                        : FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    _width / (maxWidth / 8),
                    _width / (maxWidth / 4),
                    _width / (maxWidth / 4),
                    _width / (maxWidth / 4)),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 0, _width / (maxWidth / 12), 0),
                    child: sideAdminController.returnIconFor(itemName!),
                  ),
                  (!sideAdminController.isActive(itemName!))
                      ? Flexible(
                          child: CustomText(
                          text: itemName!,
                          size: _width / (maxWidth / 14),
                          weight: sideAdminController.isHovering(itemName!)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ))
                      : Flexible(
                          child: CustomText(
                            text: itemName!,
                            size: _width / (maxWidth / 16),
                            weight: FontWeight.bold,
                          ),
                        )
                ]),
              ),
            ),
          )),
    );
  }
}
