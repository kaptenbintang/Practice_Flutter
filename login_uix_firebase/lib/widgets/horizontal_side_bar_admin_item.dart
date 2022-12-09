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

class HorizontalAdminBarItem extends StatelessWidget {
  final String? itemName;
  final void Function()? onTap;
  const HorizontalAdminBarItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? sideAdminController.onHover(itemName!)
            : sideAdminController.onHover("not hovering");
      },
      child: Obx(() => Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: sideAdminController.isActive(itemName!)
                    ? FlutterFlowTheme.of(context).secondaryBackground
                    : sideAdminController.isHovering(itemName!)
                        ? lightGrey.withOpacity(.1)
                        : FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 4, 4, 4),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                    child: sideAdminController.returnIconFor(itemName!),
                  ),
                  (!sideAdminController.isActive(itemName!))
                      ? Flexible(
                          child: CustomText(
                          text: itemName!,
                          size: 14,
                          weight: sideAdminController.isHovering(itemName!)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ))
                      : Flexible(
                          child: CustomText(
                            text: itemName!,
                            size: 14,
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
