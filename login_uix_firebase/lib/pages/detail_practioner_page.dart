import 'package:hive/hive.dart';
import 'package:login_uix_firebase/pages/appointment_page.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/practioner_data.dart';
import '../route.dart';
import 'main_page.dart';

class DetailPagePractioner extends StatefulWidget {
  static const routeName = '/detailPage';
  final PractionerData? dataU;
  const DetailPagePractioner({super.key, required this.dataU});

  @override
  _DetailPagePractionerState createState() => _DetailPagePractionerState();
}

class _DetailPagePractionerState extends State<DetailPagePractioner> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryColor,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    100, 40, 0, 100),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.MainPagesPage);
                                            },
                                            child: Text(
                                              'Home',
                                              textAlign: TextAlign.justify,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.viewProfilePage);
                                          },
                                          child: Text(
                                            'Profile',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 20, 20, 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RouteName.HistoryBooking);
                                          },
                                          child: Text(
                                            'Booking History',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: textController,
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search Something here..',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 100, 100),
                              child: Image.asset(
                                'lib/images/Logo-Slogan-BL-H400-W1080.png',
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 12,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 20, 0, 0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.asset(
                                                'lib/images/doctor.png',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .lineColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 20, 20, 20),
                                                    child: ListView(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'Name: ' +
                                                                widget.dataU!
                                                                    .firstName
                                                                    .toString() +
                                                                ' ' +
                                                                widget.dataU!
                                                                    .lastName
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'My Approach: ' +
                                                                widget.dataU!
                                                                    .myApproach
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'My Backgrounds: ' +
                                                                widget.dataU!
                                                                    .myBackground
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'My Qualifications: ' +
                                                                widget.dataU!
                                                                    .myQualifications
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'My Specialty: ' +
                                                                widget.dataU!
                                                                    .mySpecialty
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child: Text(
                                                            'My Roles: ' +
                                                                widget.dataU!
                                                                    .myRoles
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      20, 0, 0),
                                                          child: FFButtonWidget(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  appointmentPage
                                                                      .routeName);
                                                              // print(
                                                              //     'Button pressed ...');
                                                              // final _myBox =
                                                              //     Hive.box(
                                                              //         'myBox');
                                                              // print(_myBox
                                                              //     .get('name'));
                                                            },
                                                            text:
                                                                'Make an appointment!',
                                                            options:
                                                                FFButtonOptions(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20,
                                                                          20,
                                                                          20,
                                                                          20),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius: 8,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 20, 20),
                                  child: Text(
                                    'Detail Practioner',
                                    textAlign: TextAlign.justify,
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.8, -0.9),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.14,
                                  height:
                                      MediaQuery.of(context).size.height * 0.14,
                                  decoration: BoxDecoration(),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          widget.dataU!.firstName.toString(),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .title1,
                                        ),
                                        Text(
                                          '(Speaks ' +
                                              widget.dataU!.languages
                                                  .toString() +
                                              ')',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .subtitle1,
                                        ),
                                        Text(
                                          widget.dataU!.titleMain.toString(),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
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
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   decoration: BoxDecoration(
                //     color: FlutterFlowTheme.of(context).secondaryBackground,
                //   ),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Align(
                //         alignment: AlignmentDirectional(-0.95, 0),
                //         child: Padding(
                //           padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                //           child: Text(
                //             'On going appointment',
                //             style: FlutterFlowTheme.of(context).title1,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Stack(
                //   children: [
                //     Container(
                //       width: MediaQuery.of(context).size.width,
                //       height: MediaQuery.of(context).size.height * 0.5,
                //       decoration: BoxDecoration(
                //         color: FlutterFlowTheme.of(context).secondaryColor,
                //         borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(0),
                //           bottomRight: Radius.circular(0),
                //           topLeft: Radius.circular(60),
                //           topRight: Radius.circular(60),
                //         ),
                //       ),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.max,
                //         children: [
                //           Text(
                //             'footer here',
                //             style: FlutterFlowTheme.of(context).title1,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
