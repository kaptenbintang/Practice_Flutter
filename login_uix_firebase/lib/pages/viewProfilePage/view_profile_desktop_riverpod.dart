// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/auth/provider/auth_state_provider.dart';
import 'package:login_uix_firebase/auth/provider/user_id_provider.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_icon_button.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';

import 'package:login_uix_firebase/pages/landing_layout.dart';

import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/user_info/providers/user_info_model_provider.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';

import '../../constant/controllers.dart';
import '../../helper/responsive.dart';
import '../../routing/routes.dart';

class ProfileRiverpodPage2 extends ConsumerWidget {
  static const routeName = '/profileViewPageRiverpod';

  const ProfileRiverpodPage2({super.key});

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
    final userUid = ref.watch(userIdProvider);
    final userInfoModel = ref.watch(
      userInfoModelProvider(userUid.toString()),
    );
    return userInfoModel.when(
      data: (data) {
        String isRoleadminorUser = data.roles;
        return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF1F4F8),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(screenWidth / (width / 70)),
              child: AppBar(
                actions: const [],
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: Padding(
                  padding: EdgeInsets.only(top: screenWidth / (width / 10)),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: screenWidth / (width / 30),
                    borderWidth: 1,
                    buttonSize: screenWidth / (width / 50),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: screenWidth / (width / 30),
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                      Navigator.pop(context);
                    },
                  ),
                ),

                title: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, screenWidth / (width / 10), 0, 0),
                  child: Text(
                    'Profile',
                    style: FlutterFlowTheme.of(context).title2.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: screenWidth / (width / 30),
                        ),
                  ),
                ),

                // actions: [],
                centerTitle: true,
                elevation: 2,
              ),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //ProfileInfo
                  // Generated code for this profileInfo Widget...
                  Container(
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 24),
                          screenWidth / (width / 12),
                          screenWidth / (width / 24),
                          screenWidth / (width / 12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth / (width / 70),
                            height: screenWidth / (width / 70),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F4F8),
                              borderRadius: BorderRadius.circular(
                                  screenWidth / (width / 12)),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 2),
                                  screenWidth / (width / 2),
                                  screenWidth / (width / 2),
                                  screenWidth / (width / 2)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 12)),
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 16), 0, 0, 0),
                            child: SizedBox(
                              width: screenWidth / (width / 250),
                              height: screenWidth / (width / 70),
                              child: Column(
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
                                          fontSize: screenWidth / (width / 20),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, screenWidth / (width / 4), 0, 0),
                                    child: Text(
                                      data.email.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF897DEE),
                                            fontSize:
                                                screenWidth / (width / 14),
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.roles.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                                fontSize:
                                                    screenWidth / (width / 14),
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Text(
                                          data.clientType.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                                fontSize:
                                                    screenWidth / (width / 14),
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Text(
                                          data['clientcode'],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                                fontSize:
                                                    screenWidth / (width / 14),
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 12),
                            0,
                            screenWidth / (width / 12)),
                        child: Text(
                          'Account Settings',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xFF101213),
                                    fontSize: screenWidth / (width / 14),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  (isRoleadminorUser == "admin" ||
                          isRoleadminorUser == "superadmin")
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.changePWPage);
                                  },
                                  child: Container(
                                    width: 500,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color(0x3416202A),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 8, 8, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 0, 0),
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
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 0),
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
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                )
                              ],
                            ),
                          ],
                        )
                      : isRoleadminorUser == "practioner"
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RouteName.changePWPage);
                                      },
                                      child: Container(
                                        width: 500,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color: Color(0x3416202A),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 8, 8, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Text(
                                                  'Schedule',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            Color(0xFF57636C),
                                                        fontSize: 14,
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
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
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
                                    )
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                              ],
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
                            textStyle:
                                FlutterFlowTheme.of(context).bodyText2.override(
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
            ));
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
