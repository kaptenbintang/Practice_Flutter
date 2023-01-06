// ignore_for_file: prefer_const_constructors

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
import 'package:login_uix_firebase/widgets/animations/small_error_animation_view.dart';
import 'package:recase/recase.dart';

import '../../constant/controllers.dart';
import '../../helper/responsive.dart';
import '../../routing/routes.dart';

class mainSchedulePage extends ConsumerWidget {
  static const routeName = '/mainSchedulePage';

  const mainSchedulePage({super.key});

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
        return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF1F4F8),
            appBar: AppBar(
              actions: const [],
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: screenWidth / (width / 30),
                  borderWidth: 1,
                  buttonSize: screenWidth / (width / 30),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: screenWidth / (width / 20),
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                    Navigator.pop(context);
                  },
                ),
              ),

              title: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
                child: Text(
                  'Schedule',
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
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //ProfileInfo
                  // Generated code for this profileInfo Widget...
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
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
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      screenWidth / (width / 16), 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              fontSize:
                                                  screenWidth / (width / 20),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                              'Manage your schedule',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xFF101213),
                                    fontSize: screenWidth / (width / 14),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.timeSchedulePage);
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      screenWidth / (width / 12), 0, 0, 0),
                                  child: Text(
                                    'Time Schedule',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: screenWidth / (width / 14),
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.9, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF57636C),
                                      size: screenWidth / (width / 18),
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
                                context, RouteName.blackOutPage);
                          },
                          child: Container(
                            width: screenWidth / (width / 500),
                            height: screenWidth / (width / 60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: screenWidth / (width / 5),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 12), 0, 0, 0),
                                    child: Text(
                                      'Blackout Date',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF57636C),
                                            fontSize:
                                                screenWidth / (width / 14),
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: screenWidth / (width / 18),
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
                            0, screenWidth / (width / 12), 0, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.specialDatePage);
                          },
                          child: Container(
                            width: screenWidth / (width / 500),
                            height: screenWidth / (width / 60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: screenWidth / (width / 5),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 12), 0, 0, 0),
                                    child: Text(
                                      'Special/Off Date',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF57636C),
                                            fontSize:
                                                screenWidth / (width / 14),
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF57636C),
                                        size: screenWidth / (width / 18),
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
