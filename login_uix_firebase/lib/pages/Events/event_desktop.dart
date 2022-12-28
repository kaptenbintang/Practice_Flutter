// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/responsive.dart';

class EventDesktop extends StatefulWidget {
  const EventDesktop({super.key});

  @override
  State<EventDesktop> createState() => _EventDesktopState();
}

class _EventDesktopState extends State<EventDesktop> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    return // Generated code for this MainColumn Widget...
        SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  'assets/images/backgroundImage1.jpg',
                ).image,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'TIMELINE OF',
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18),
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Text(
                    'Events',
                    style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 24)),
                  ),
                ),
                Text(
                  '#ReachingOutIsAStrength',
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18),
                      ),
                ),
                Container(
                  width: 550,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Text(
                      'Coaching, Counseling, Assessments, Psychological Services, Employee Assistance Programs, and Professional Training Programs for all Ages',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth / (width / 14)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, screenWidth / (width / 10), 0, 0),
                  child: Text(
                    'Click on the event to RSVP your seat or buy your tickets.',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, screenWidth / (width / 10), 0, 0),
                  child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                        connectorTheme: ConnectorThemeData(
                            space: screenWidth / (width / 40),
                            color: FlutterFlowTheme.of(context).secondaryColor),
                        indicatorTheme: IndicatorThemeData(
                            color: FlutterFlowTheme.of(context).tertiaryColor)),
                    builder: TimelineTileBuilder.connectedFromStyle(
                      contentsAlign: ContentsAlign.alternating,
                      oppositeContentsBuilder:
                          (context, index1) => // Date Widget...
                              Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / (width / 8)),
                        child: Container(
                          width: screenWidth / (width / 280),
                          height: screenWidth / (width / 140),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            borderRadius: BorderRadius.circular(
                                screenWidth / (width / 8)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Text(
                                      '28',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Text(
                                      ' December 2022',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Icon(
                                      Icons.place_outlined,
                                      color: Colors.black,
                                      size: screenWidth / (width / 24),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Text(
                                      'Online & In-Person, E-02-02 \nJalan Lagoon Selatan Subang Jaya, \nSelangor 47500 Malaysia',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  screenWidth / (width / 12),
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.black,
                                      size: screenWidth / (width / 24),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 8),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 8),
                                        0),
                                    child: Text(
                                      'Free',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  screenWidth / (width / 12),
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      contentsBuilder: (context, index) => // Event Widget...
                          Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / (width / 8)),
                        child: Container(
                          width: screenWidth / (width / 300),
                          height: screenWidth / (width / 380),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: BorderRadius.circular(
                                screenWidth / (width / 8)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 8),
                                    screenWidth / (width / 5),
                                    screenWidth / (width / 8),
                                    0),
                                child: Text(
                                  'Relationships Matter – Wednesday Talk (FOC)',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 16),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 8),
                                    screenWidth / (width / 5),
                                    screenWidth / (width / 8),
                                    0),
                                child: Image.asset(
                                  'assets/images/talk.png',
                                  height: screenWidth / (width / 200),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 8),
                                    screenWidth / (width / 5),
                                    screenWidth / (width / 8),
                                    0),
                                child: Text(
                                  'Join us and learn a tip or two about what makes a relationship (be it with your parents, children, spouse, friends, colleagues, boss, etc.) healthy and strong.  Every talk will […]',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 8),
                                    screenWidth / (width / 5),
                                    screenWidth / (width / 8),
                                    0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Find Out More >>',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 12),
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: screenWidth / (width / 20),
                                      borderWidth: 1,
                                      buttonSize: screenWidth / (width / 30),
                                      icon: Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: screenWidth / (width / 15),
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      connectorStyleBuilder: (context, index) =>
                          ConnectorStyle.solidLine,
                      indicatorStyleBuilder: (context, index) =>
                          IndicatorStyle.dot,
                      itemCount: 3,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
