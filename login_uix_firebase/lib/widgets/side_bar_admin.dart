// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:login_uix_firebase/constant/controllers.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:login_uix_firebase/routing/logOutRoute.dart';
import 'package:login_uix_firebase/routing/routes.dart';
import 'package:login_uix_firebase/widgets/side_bar_admin_item.dart';

import '../auth/provider/user_id_provider.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../helper/responsive.dart';
import '../provider/profile_provider/user_profile_provider.dart';
import '../route.dart';
import '../user_info/providers/user_info_model_provider.dart';
import 'animations/error_animation_view.dart';
import 'animations/loading_animation_view.dart';

class SideBarAdmin extends ConsumerWidget {
  const SideBarAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    final userUid = ref.watch(userIdProvider);
    final userInfoModel = ref.watch(
      userInfoModelProvider(userUid.toString()),
    );
    return userInfoModel.when(
      data: (data) {
        String isRoleadminorUser = data.roles;
        return Container(
          width: _width / (maxWidth / 270),
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
            padding: EdgeInsetsDirectional.fromSTEB(
                _width / (maxWidth / 16),
                _width / (maxWidth / 16),
                _width / (maxWidth / 16),
                _width / (maxWidth / 16)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((ResponsiveWidget.isMediumScreen(context)) ||
                    (ResponsiveWidget.isLargeScreen(context)))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0,
                        _width / (maxWidth / 24), 0, _width / (maxWidth / 24)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          ResponsiveWidget.isMediumScreen(context)
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                      children: [
                        if (Theme.of(context).brightness == Brightness.light)
                          ResponsiveWidget.isMediumScreen(context)
                              ? Image.asset(
                                  'assets/images/Signature-Logo.png',
                                  width: _width / (maxWidth / 150),
                                  height: _width / (maxWidth / 45),
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/images/Signature-Logo.png',
                                  width: _width / (maxWidth / 200),
                                  height: _width / (maxWidth / 60),
                                  fit: BoxFit.fitWidth,
                                ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          ResponsiveWidget.isMediumScreen(context)
                              ? Image.asset(
                                  'assets/images/Signature-Logo.png',
                                  width: _width / (maxWidth / 150),
                                  height: _width / (maxWidth / 45),
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/images/Signature-Logo.png',
                                  width: _width / (maxWidth / 200),
                                  height: _width / (maxWidth / 60),
                                  fit: BoxFit.fitWidth,
                                ),
                      ],
                    ),
                  ),

                Expanded(
                    flex: ResponsiveWidget.isSmallScreen(context) ? 6 : 5,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return (isRoleadminorUser == "admin" ||
                                isRoleadminorUser == "superadmin")
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: sideBarAdminItems.map((itemname) {
                                  return SideBarAdminItem(
                                    itemName: itemname == LogOutRoute
                                        ? "Log Out"
                                        : itemname,
                                    onTap: () async {
                                      if (itemname == LogOutRoute) {
                                        logOutRoute(context, ref, child);
                                      }

                                      if (!sideAdminController
                                          .isActive(itemname)) {
                                        sideAdminController
                                            .changeActiveitemTo(itemname);
                                        if (ResponsiveWidget.isSmallScreen(
                                            context)) {
                                          Get.back();
                                        }
                                        navigationController
                                            .navigateTo(itemname);
                                      }
                                    },
                                  );
                                }).toList())
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: sideBarPractionerItem.map((itemname) {
                                  return SideBarPractionerItem(
                                    itemName: itemname == LogOutRoute
                                        ? "Log Out"
                                        : itemname,
                                    onTap: () async {
                                      if (itemname == LogOutRoute) {
                                        logOutRoute(context, ref, child);
                                      }

                                      if (!sideAdminController
                                          .isActive(itemname)) {
                                        sideAdminController
                                            .changeActiveitemTo(itemname);
                                        if (ResponsiveWidget.isSmallScreen(
                                            context)) {
                                          Get.back();
                                        }
                                        navigationController
                                            .navigateTo(itemname);
                                      }
                                    },
                                  );
                                }).toList());
                      },
                    )),
                // Generated code for this Column Widget...
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.viewProfilePage);
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(
                                  _width / (maxWidth / 12)),
                            ),
                            child: ResponsiveWidget.isLargeScreen(context)
                                ? Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, _width / (maxWidth / 16)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              _width / (maxWidth / 40)),
                                          child: (data.profilePic.toString() ==
                                                  '')
                                              ? Icon(Icons.person)
                                              : Image.network(
                                                  data.profilePic!,
                                                  width:
                                                      _width / (maxWidth / 40),
                                                  height:
                                                      _width / (maxWidth / 40),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    _width / (maxWidth / 16),
                                                    0,
                                                    0,
                                                    0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    data['firstName'] +
                                                        ' ' +
                                                        data['lastName'],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: _width /
                                                              (maxWidth / 18),
                                                        )),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0,
                                                          _width /
                                                              (maxWidth / 4),
                                                          0,
                                                          0),
                                                  child: Text(
                                                    data['email'],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: _width /
                                                              (maxWidth / 12),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: _width / (maxWidth / 8)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              _width / (maxWidth / 40)),
                                          child: Image(
                                            image: AssetImage(
                                                'lib/images/relationary.png'),
                                            width: _width / (maxWidth / 40),
                                            height: _width / (maxWidth / 40),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Consumer(
                                        builder: (context, ref, child) {
                                          final userData = ref.watch(
                                            userDetailProvider,
                                          );
                                          final model = userData.value;
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                model?['firstName'] +
                                                    ' ' +
                                                    model?['lastName'],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 13,
                                                        ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 4, 0, 0),
                                                child: Text(
                                                  model?['email'],
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 10,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const ErrorAnimationView();
      },
      loading: () {
        return const LoadingAnimationView();
      },
    );
  }
}
