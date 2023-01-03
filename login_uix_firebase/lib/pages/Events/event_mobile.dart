// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:timelines/timelines.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class EventMobile extends StatefulWidget {
  const EventMobile({super.key});

  @override
  State<EventMobile> createState() => _EventMobileState();
}

class _EventMobileState extends State<EventMobile> {
  @override
  Widget build(BuildContext context) {
    return // Generated code for this MainColumn Widget...
        SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //Title
          Container(
            height: Dimensions.height100 * 2,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: Text('TIMELINE OF',
                      style: FlutterFlowTheme.of(context).bodyText1),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: Text('Events',
                      style: FlutterFlowTheme.of(context).title3),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: Text('#ReachingOutIsAStrength',
                      style: FlutterFlowTheme.of(context).bodyText1),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: Text(
                    'Coaching, Counseling, Assessments, Psychological Services, Employee Assistance Programs, and Professional Training Programs for all Ages',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.font12,
                        ),
                  ),
                ),
              ],
            ),
          ),
          //Event Timeline
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Sub Title
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: Text(
                    'Click on the event to RSVP your seat or buy your tickets.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.font16,
                        ),
                  ),
                ),
                //Timeline Widget
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, 0, 0),
                  child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                        connectorTheme: ConnectorThemeData(
                            space: Dimensions.width20 * 2,
                            color: FlutterFlowTheme.of(context).secondaryColor),
                        indicatorTheme: IndicatorThemeData(
                            color: FlutterFlowTheme.of(context).tertiaryColor)),
                    builder: TimelineTileBuilder.connectedFromStyle(
                      contentsAlign: ContentsAlign.alternating,
                      oppositeContentsBuilder:
                          (context, index1) => // Date Widget...
                              Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width08),
                        child: Container(
                          width: Dimensions.width100 +
                              Dimensions.width10 * 5 +
                              Dimensions.width10 / 2,
                          height: Dimensions.height100 +
                              Dimensions.height20 +
                              Dimensions.height05,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.height08),
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
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Text(
                                      '28',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: Dimensions.font14,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Text(
                                      ' December 2022',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: Dimensions.font10,
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
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Icon(
                                      Icons.place_outlined,
                                      color: Colors.black,
                                      size: Dimensions.iconSize18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Text(
                                      'Online & In-Person,\nE-02-02 \nJalan Lagoon Selatan\nSubang Jaya, \nSelangor 47500 Malaysia',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: Dimensions.font16 / 2,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.black,
                                      size: Dimensions.iconSize18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width08,
                                        Dimensions.height05,
                                        Dimensions.width08,
                                        0),
                                    child: Text(
                                      'Free',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: Dimensions.font10,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      contentsBuilder: (context,
                              index) => // Generated code for this Event Widget...
                          Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width08),
                        child: Container(
                          width: Dimensions.width100 +
                              Dimensions.width60 +
                              Dimensions.width10 / 2,
                          height: Dimensions.height100 * 2 +
                              Dimensions.height45 +
                              Dimensions.font10,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.height08),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    Dimensions.width08,
                                    Dimensions.height05,
                                    Dimensions.width08,
                                    0),
                                child: Text(
                                  'Relationships Matter – Wednesday Talk (FOC)',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width08,
                                          Dimensions.height05,
                                          Dimensions.width08,
                                          0),
                                      child: Image.asset(
                                        'assets/images/talk.png',
                                        width: Dimensions.width100,
                                        height: Dimensions.height100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    Dimensions.width08,
                                    Dimensions.height05,
                                    Dimensions.width08,
                                    0),
                                child: Text(
                                  'Join us and learn a tip or two about what makes a relationship (be it with your parents, children, spouse, friends, colleagues, boss, etc.) healthy and strong.  Every talk will […]',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font16 / 2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    Dimensions.width08,
                                    Dimensions.height05,
                                    Dimensions.width08,
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
                                            fontSize: Dimensions.font10,
                                          ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: Dimensions.height20,
                                      borderWidth: 1,
                                      buttonSize: Dimensions.height30,
                                      icon: Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: Dimensions.font15,
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
