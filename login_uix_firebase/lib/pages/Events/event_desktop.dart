// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class EventDesktop extends StatefulWidget {
  const EventDesktop({super.key});

  @override
  State<EventDesktop> createState() => _EventDesktopState();
}

class _EventDesktopState extends State<EventDesktop> {
  @override
  Widget build(BuildContext context) {
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
                  style: FlutterFlowTheme.of(context).subtitle1,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Text(
                    'Events',
                    style: FlutterFlowTheme.of(context).title1,
                  ),
                ),
                Text(
                  '#ReachingOutIsAStrength',
                  style: FlutterFlowTheme.of(context).subtitle1,
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
                      style: FlutterFlowTheme.of(context).bodyText1,
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Click on the event to RSVP your seat or buy your tickets.',
                    style: FlutterFlowTheme.of(context).title3,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                        connectorTheme: ConnectorThemeData(
                            space: 40,
                            color: FlutterFlowTheme.of(context).secondaryColor),
                        indicatorTheme: IndicatorThemeData(
                            color: FlutterFlowTheme.of(context).tertiaryColor)),
                    builder: TimelineTileBuilder.connectedFromStyle(
                      contentsAlign: ContentsAlign.alternating,
                      oppositeContentsBuilder:
                          (context, index1) => // Date Widget...
                              Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 280,
                          height: 140,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            borderRadius: BorderRadius.circular(8),
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
                                        8, 5, 8, 0),
                                    child: Text(
                                      '28',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 5, 8, 0),
                                    child: Text(
                                      ' December 2022',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
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
                                        8, 5, 8, 0),
                                    child: Icon(
                                      Icons.place_outlined,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 5, 8, 0),
                                    child: Text(
                                      'Online & In-Person, E-02-02 \nJalan Lagoon Selatan Subang Jaya, \nSelangor 47500 Malaysia',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
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
                                        8, 5, 8, 0),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 5, 8, 0),
                                    child: Text(
                                      'Free',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
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
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 300,
                          height: 380,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 5, 8, 0),
                                child: Text(
                                  'Relationships Matter – Wednesday Talk (FOC)',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 5, 8, 0),
                                child: Image.asset(
                                  'assets/images/talk.png',
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 5, 8, 0),
                                child: Text(
                                  'Join us and learn a tip or two about what makes a relationship (be it with your parents, children, spouse, friends, colleagues, boss, etc.) healthy and strong.  Every talk will […]',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 5, 8, 0),
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
                                            fontSize: 12,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20,
                                      borderWidth: 1,
                                      buttonSize: 30,
                                      icon: Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 15,
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
