// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/responsive.dart';
import '../../model/practioner_models/practioner.dart';
import '../../route.dart';
import '../appointment_page_riverpod_ver2.dart';

class DetailPractionerDesktop extends ConsumerWidget {
  final Practioner practioner;
  const DetailPractionerDesktop(this.practioner, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Top nav bar
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment:
                      AlignmentDirectional(screenWidth / (width / -0.95), 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        screenWidth / (width / 100),
                        screenWidth / (width / 40),
                        0,
                        screenWidth / (width / 100)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(
                                screenWidth / (width / -1), 0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.MainPagesPage);
                                },
                                child: Text(
                                  'Home',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 14)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.viewProfilePage);
                              },
                              child: Text(
                                'Profile',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 14)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20)),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.historyBookingRiverpod);
                              },
                              child: Text(
                                'Booking History',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 14)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search Something here..',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 14)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 20)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 20)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenWidth / (width / 20)),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0,
                      screenWidth / (width / 40),
                      screenWidth / (width / 100),
                      screenWidth / (width / 100)),
                  child: Image.asset(
                    'lib/images/Logo-Slogan-BL-H400-W1080.png',
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: MediaQuery.of(context).size.height * 0.06,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            //White Content
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth / (width / 10)),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: screenWidth / (width / 12),
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenWidth / (width / 30)),
                    bottomRight: Radius.circular(screenWidth / (width / 30)),
                    topLeft: Radius.circular(screenWidth / (width / 60)),
                    topRight: Radius.circular(screenWidth / (width / 60)),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: screenWidth / (width / 10)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Practioner info and pp
                      Column(
                        children: [
                          //Practioner Info
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenWidth / (width / 10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.18,
                              decoration: BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    practioner.firstName.toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 24)),
                                  ),
                                  Text(
                                    '(Speaks ' +
                                        practioner.languages.toString() +
                                        ')',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 20)),
                                  ),
                                  Text(
                                    practioner.titleMain.toString(),
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Practioner pp
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                screenWidth / (width / 20)),
                            child: Image.network(
                              practioner.profilePic,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.4,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),

                      //Detail practioner info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Subtitle
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                screenWidth / (width / 10),
                                screenWidth / (width / 20),
                                screenWidth / (width / 20)),
                            child: Text(
                              'Detail Practioner',
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context)
                                  .title1
                                  .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 24)),
                            ),
                          ),
                          //Detail Practioner grey content
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: screenWidth / (width / 20)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.65,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).lineColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: screenWidth / (width / 12),
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(
                                    screenWidth / (width / 20)),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    //Name
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'Name: ' +
                                            practioner.firstName.toString() +
                                            ' ' +
                                            practioner.lastName.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Approach
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'My Approach: ' +
                                            practioner.myApproach.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Backgrounds
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'My Backgrounds: ' +
                                            practioner.myBackground.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Qualifications
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'My Qualifications: ' +
                                            practioner.myQualifications
                                                .toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Speciality
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'My Specialty: ' +
                                            practioner.mySpecialty.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Roles
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10),
                                          screenWidth / (width / 10)),
                                      child: Text(
                                        'My Roles: ' +
                                            practioner.myRoles.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                    //Make an appointment button
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 300),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 300),
                                          0),
                                      child: FFButtonWidget(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentPageRiverpodVersion2(
                                                practioner: practioner,
                                              ),
                                            ),
                                          );
                                        },
                                        text: 'Make an appointment!',
                                        options: FFButtonOptions(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 20),
                                                  screenWidth / (width / 20),
                                                  screenWidth / (width / 20),
                                                  screenWidth / (width / 20)),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: screenWidth /
                                                          (width / 16)),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              screenWidth / (width / 8),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
