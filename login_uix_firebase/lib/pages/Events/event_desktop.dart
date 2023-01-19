// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow.dart';
import 'package:login_uix_firebase/model/events/events_data.dart';
import 'package:timelines/timelines.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class EventDesktop extends StatefulWidget {
  const EventDesktop({super.key});

  @override
  State<EventDesktop> createState() => _EventDesktopState();
}

class _EventDesktopState extends State<EventDesktop> {
  GlobalKey<ScaffoldState>? _scaffoldKey;
  Future<List<EventsData>>? eventsList;
  List<EventsData>? retrievedEventsList;
  DataService service = DataService();
  List<bool>? selected;
  String? url;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    eventsList = service.retrieveEventsAll();
    retrievedEventsList = await service.retrieveEventsAll();
    selected =
        List<bool>.generate(retrievedEventsList!.length, (int index) => false);
  }

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
            child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                  child: FutureBuilder(
                      future: eventsList,
                      builder:
                          (context, AsyncSnapshot<List<EventsData>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                                connectorTheme: ConnectorThemeData(
                                    space: screenWidth / (width / 40),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryColor),
                                indicatorTheme: IndicatorThemeData(
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor)),
                            builder: TimelineTileBuilder.connectedFromStyle(
                              contentsAlign: ContentsAlign.alternating,
                              oppositeContentsBuilder: (context, indexs) {
                                // Date Widget...
                                EventsData event = retrievedEventsList![indexs];
                                print("hai2");
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth / (width / 8)),
                                  child: Container(
                                    width: screenWidth / (width / 280),
                                    height: screenWidth / (width / 140),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 8)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: Text(
                                                DateFormat.d().format(
                                                    event.eventsDate!.toDate()),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 18),
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: Text(
                                                DateFormat.yMMM().format(
                                                    event.eventsDate!.toDate()),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14),
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: Icon(
                                                Icons.place_outlined,
                                                color: Colors.black,
                                                size:
                                                    screenWidth / (width / 24),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: SizedBox(
                                                width:
                                                    screenWidth / (width / 220),
                                                height:
                                                    screenWidth / (width / 55),
                                                child: Text(
                                                  event.eventsLocation!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 12),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: Icon(
                                                Icons.attach_money,
                                                color: Colors.black,
                                                size:
                                                    screenWidth / (width / 24),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      screenWidth / (width / 5),
                                                      screenWidth / (width / 8),
                                                      0),
                                              child: Text(
                                                event.eventsPrice!,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: screenWidth /
                                                            (width / 12),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              contentsBuilder: (context, indexs) {
                                EventsData event = retrievedEventsList![indexs];
                                // Event Widget...
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth / (width / 8)),
                                  child: Container(
                                    width: screenWidth / (width / 300),
                                    height: screenWidth / (width / 400),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      borderRadius: BorderRadius.circular(
                                          screenWidth / (width / 8)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 5),
                                                  screenWidth / (width / 8),
                                                  0),
                                          child: Text(
                                            event.eventsTitle!,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 16),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 5),
                                                  screenWidth / (width / 8),
                                                  0),
                                          child: Image.network(
                                            event.eventsImage!,
                                            height: screenWidth / (width / 200),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 8),
                                                  screenWidth / (width / 5),
                                                  screenWidth / (width / 8),
                                                  0),
                                          child: Text(
                                            event.eventsDescription!,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 12),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 12),
                                                        ),
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius:
                                                    screenWidth / (width / 20),
                                                borderWidth: 1,
                                                buttonSize:
                                                    screenWidth / (width / 30),
                                                icon: Icon(
                                                  Icons.add,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: screenWidth /
                                                      (width / 15),
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              connectorStyleBuilder: (context, indexs) =>
                                  ConnectorStyle.solidLine,
                              indicatorStyleBuilder: (context, indexs) =>
                                  IndicatorStyle.dot,
                              itemCount: retrievedEventsList!.length,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            retrievedEventsList!.isEmpty) {
                          return const ErrorAnimationView();
                        } else {
                          return const LoadingAnimationView();
                        }
                      })),
            ]),
          ),
        ],
      ),
    );
  }
}
