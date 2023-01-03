import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/helper/responsive.dart';

import '../constant/controllers.dart';
import '../constant/style.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'custom_text.dart';

class VerticalSideAdminItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const VerticalSideAdminItem({super.key, this.itemName, this.onTap});

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
        child: Obx(
          () => Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
            child: Container(
              width: double.infinity,
              height: ResponsiveWidget.isMediumScreen(context) ? null : 55,
              decoration: BoxDecoration(
                color: sideAdminController.isActive(itemName!)
                    ? FlutterFlowTheme.of(context).secondaryBackground
                    : sideAdminController.isHovering(itemName!)
                        ? lightGrey.withOpacity(.1)
                        : FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sideAdminController.returnIconFor(itemName!),
                  (!sideAdminController.isActive(itemName!))
                      ? CustomText(
                          text: itemName!,
                          size: _width / (maxWidth / 14),
                          weight: sideAdminController.isHovering(itemName!)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          align: TextAlign.center,
                        )
                      : CustomText(
                          text: itemName!,
                          size: _width / (maxWidth / 16),
                          weight: FontWeight.bold,
                          align: TextAlign.center,
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
