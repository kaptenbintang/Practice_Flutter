// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/routing/logOutRoute.dart';
import 'package:login_uix_firebase/routing/routes.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin_item.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../helper/responsive.dart';

class SideBarAdmin extends StatelessWidget {
  const SideBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      width: 270,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((ResponsiveWidget.isMediumScreen(context)) ||
                (ResponsiveWidget.isLargeScreen(context)))
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: ResponsiveWidget.isMediumScreen(context)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (Theme.of(context).brightness == Brightness.light)
                      Image.asset(
                        'assets/images/Signature-Logo.png',
                        width: ResponsiveWidget.isMediumScreen(context)
                            ? Dimensions.width20 * 5 -
                                Dimensions.width10 -
                                Dimensions.width30 / 10 -
                                Dimensions.width10 / 10
                            : Dimensions.width20 * 5 + Dimensions.width30,
                        height: Dimensions.width30 + Dimensions.width10,
                        fit: BoxFit.fitWidth,
                      ),
                    if (Theme.of(context).brightness == Brightness.dark)
                      Image.asset(
                        'assets/images/Signature-Logo.png',
                        width: ResponsiveWidget.isMediumScreen(context)
                            ? Dimensions.width20 * 5 -
                                Dimensions.width10 -
                                Dimensions.width30 / 10 -
                                Dimensions.width10 / 10
                            : Dimensions.width20 * 5 + Dimensions.width30,
                        height: Dimensions.width30 + Dimensions.width10,
                        fit: BoxFit.fitWidth,
                      ),
                  ],
                ),
              ),

            Expanded(
                flex: ResponsiveWidget.isSmallScreen(context) ? 6 : 5,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: sideBarAdminItems
                        .map((itemname) => SideBarAdminItem(
                              itemName: itemname == LogOutRoute
                                  ? "Log Out"
                                  : itemname,
                              onTap: () {
                                if (itemname == LogOutRoute) {
                                  logOutRoute();
                                }

                                if (!sideAdminController.isActive(itemname)) {
                                  sideAdminController
                                      .changeActiveitemTo(itemname);
                                  if (ResponsiveWidget.isSmallScreen(context)) {
                                    Get.back();
                                  }
                                  navigationController.navigateTo(itemname);
                                }
                              },
                            ))
                        .toList())),
            // Generated code for this Column Widget...
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ResponsiveWidget.isLargeScreen(context)
                          ? Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/onboarding-01-bv872t/assets/fnp38dj9xs3p/app_icon@1x.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'NoCodeUI',
                                            style: FlutterFlowTheme.of(context)
                                                .subtitle1,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 0),
                                            child: Text(
                                              'nocodeui.io',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          : Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/onboarding-01-bv872t/assets/fnp38dj9xs3p/app_icon@1x.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'NoCodeUI',
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        'nocodeui.io',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
