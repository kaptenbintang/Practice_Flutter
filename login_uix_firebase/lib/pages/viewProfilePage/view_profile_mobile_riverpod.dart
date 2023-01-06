// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';

import 'package:login_uix_firebase/flutter_flow/flutter_flow_icon_button.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';

import 'package:login_uix_firebase/pages/landing_layout.dart';
import 'package:login_uix_firebase/provider/profile_provider/user_profile_provider.dart';

import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';

import '../../constant/controllers.dart';
import '../../helper/responsive.dart';
import '../../routing/routes.dart';

class ProfilePageMobileWidgetRiverpod extends ConsumerWidget {
  static const routeName = '/profileViewPageRiverpod';

  const ProfilePageMobileWidgetRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(
        userDetailProvider,
      );
      final userUid = ref.watch(userIdProvider)!;
      final userInfoModel = ref.watch(
        userInfoModelProvider(userUid),
      );
      return userInfoModel.when(
        data: (data) {
          String isRoleadminorUser = data.roles;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF1F4F8),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 20,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Profile',
                style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Urbanist',
                      color: Color(0xFF101213),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 1,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Color(0xFFF1F4F8),
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4F8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Icon(Icons.person),
                              // CachedNetworkImage(
                              //   imageUrl:
                              //       'https://images.unsplash.com/photo-1592520113018-180c8bc831c9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTI3fHxwcm9maWxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                              //   width: 100,
                              //   height: 100,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                        ),
                        // Generated code for this Column Widget...
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.firstName}' +
                                      ' ' +
                                      '${data.lastName}',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Color(0xFF101213),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    data.email.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF897DEE),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        data.roles.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        data.clientType.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        data['clientcode'],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 12, 0, 12),
                        child: Text(
                          'Account Settings',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xFF101213),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      (isRoleadminorUser == "admin" ||
                              isRoleadminorUser == "superadmin")
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.changePWPage);
                                  },
                                  child: Container(
                                    width: screenWidth / (width / 500),
                                    height: screenWidth / (width / 60),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x3416202A),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 12)),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 8),
                                          screenWidth / (width / 8),
                                          screenWidth / (width / 8),
                                          screenWidth / (width / 8)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 12),
                                                    0,
                                                    0,
                                                    0),
                                            child: Text(
                                              'Change Password',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF57636C),
                                                        fontSize: screenWidth /
                                                            (width / 14),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0.9, 0),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Color(0xFF57636C),
                                                size:
                                                    screenWidth / (width / 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, screenWidth / (width / 12), 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.editProfilePage);
                                    },
                                    child: Container(
                                      width: screenWidth / (width / 500),
                                      height: screenWidth / (width / 60),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius:
                                                screenWidth / (width / 5),
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 12)),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth /
                                                          (width / 12),
                                                      0,
                                                      0,
                                                      0),
                                              child: Text(
                                                'Edit Profile',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF57636C),
                                                      fontSize: screenWidth /
                                                          (width / 14),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.9, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF57636C),
                                                  size: screenWidth /
                                                      (width / 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.mainSchedulePage);
                                    },
                                    child: Container(
                                      width: screenWidth / (width / 500),
                                      height: screenWidth / (width / 60),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius:
                                                screenWidth / (width / 5),
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 12)),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth /
                                                          (width / 12),
                                                      0,
                                                      0,
                                                      0),
                                              child: Text(
                                                'Schedule',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF57636C),
                                                      fontSize: screenWidth /
                                                          (width / 14),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.9, 0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF57636C),
                                                  size: screenWidth /
                                                      (width / 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : isRoleadminorUser == "practioner"
                              ? Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.changePWPage);
                                      },
                                      child: Container(
                                        width: screenWidth / (width / 500),
                                        height: screenWidth / (width / 60),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color: Color(0x3416202A),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              screenWidth / (width / 12)),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 8)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        screenWidth /
                                                            (width / 12),
                                                        0,
                                                        0,
                                                        0),
                                                child: Text(
                                                  'Schedule',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF57636C),
                                                        fontSize: screenWidth /
                                                            (width / 14),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.9, 0),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF57636C),
                                                    size: screenWidth /
                                                        (width / 18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, screenWidth / (width / 12), 0, 0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RouteName.editProfilePage);
                                        },
                                        child: Container(
                                          width: screenWidth / (width / 500),
                                          height: screenWidth / (width / 60),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius:
                                                    screenWidth / (width / 5),
                                                color: Color(0x3416202A),
                                                offset: Offset(0, 2),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                screenWidth / (width / 12)),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    screenWidth / (width / 8),
                                                    screenWidth / (width / 8),
                                                    screenWidth / (width / 8),
                                                    screenWidth / (width / 8)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          screenWidth /
                                                              (width / 12),
                                                          0,
                                                          0,
                                                          0),
                                                  child: Text(
                                                    'Edit Profile',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14),
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            screenWidth /
                                                                (width / 0.9),
                                                            0),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Color(0xFF57636C),
                                                      size: screenWidth /
                                                          (width / 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, screenWidth / (width / 12), 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.editProfilePage);
                                    },
                                    child: Container(
                                      width: screenWidth / (width / 500),
                                      height: screenWidth / (width / 60),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius:
                                                screenWidth / (width / 5),
                                            color: Color(0x3416202A),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 12)),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8),
                                            screenWidth / (width / 8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth /
                                                          (width / 12),
                                                      0,
                                                      0,
                                                      0),
                                              child: Text(
                                                'Edit Profile',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Outfit',
                                                      color: Color(0xFF57636C),
                                                      fontSize: screenWidth /
                                                          (width / 14),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    screenWidth / (width / 0.9),
                                                    0),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color(0xFF57636C),
                                                  size: screenWidth /
                                                      (width / 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 20),
                            0,
                            screenWidth / (width / 20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                await ref
                                    .read(authStateProvider.notifier)
                                    .logOut()
                                    .then((_) {
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  LandingLayout();
                                  menuController
                                      .changeActiveitemTo(sideMenuItems[0]);
                                });

                                //     .then((_) {
                                //   // Navigator.pushReplacement(
                                //   //   context,
                                //   //   MaterialPageRoute(
                                //   //     builder: (context) => LandingLayout(),
                                //   //   ),
                                //   // );
                                //   Navigator.of(context).pop();
                                //   LandingLayout();
                                // });
                              },
                              text: 'Log Out',
                              options: FFButtonOptions(
                                height: screenWidth / (width / 40),
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF101213),
                                      fontSize: screenWidth / (width / 14),
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 1,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    });
  }
}
