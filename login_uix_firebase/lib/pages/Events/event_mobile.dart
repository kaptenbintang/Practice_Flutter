// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';
import 'package:timelines/timelines.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/database_service.dart';
import '../../model/events/events_data.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class EventMobile extends StatefulWidget {
  const EventMobile({super.key});

  @override
  State<EventMobile> createState() => _EventMobileState();
}

class _EventMobileState extends State<EventMobile> {
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
                      0, Dimensions.height10, 0, Dimensions.height10),
                  child: FutureBuilder(
                      future: eventsList,
                      builder:
                          (context, AsyncSnapshot<List<EventsData>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                                connectorTheme: ConnectorThemeData(
                                    space: Dimensions.width20 * 2,
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
                                return Padding(
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
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height08),
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
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
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
                                                              Dimensions.font14,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
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
                                                              Dimensions.font10,
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
                                                      0),
                                              child: SizedBox(
                                                width: Dimensions.width100,
                                                height: Dimensions.height10 * 5,
                                                child: Text(
                                                  event.eventsLocation!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            Dimensions.font16 /
                                                                2,
                                                      ),
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
                                                      0),
                                              child: SizedBox(
                                                width: Dimensions.width100,
                                                height: Dimensions.height10 * 3,
                                                child: Text(
                                                  event.eventsPrice!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            Dimensions.font10,
                                                      ),
                                                ),
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
                                // Event Widget...
                                EventsData event = retrievedEventsList![indexs];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width08),
                                  child: Container(
                                    width: Dimensions.width100 +
                                        Dimensions.width60 +
                                        Dimensions.width10 / 2,
                                    height: Dimensions.height100 * 3,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height08),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
                                                      0),
                                              child: Text(
                                                event.eventsTitle!,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              Dimensions.font10,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
                                                      0),
                                              child: Image.network(
                                                event.eventsImage!,
                                                width: Dimensions.height100,
                                                height: Dimensions.height100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      Dimensions.width08,
                                                      Dimensions.height05,
                                                      Dimensions.width08,
                                                      0),
                                              child: Text(
                                                event.eventsDescription!,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              Dimensions.font10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              Dimensions.font10,
                                                        ),
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius:
                                                    Dimensions.height20,
                                                borderWidth: 1,
                                                buttonSize: Dimensions.height30,
                                                icon: Icon(
                                                  Icons.add,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: Dimensions.font15,
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
                              connectorStyleBuilder: (context, index) =>
                                  ConnectorStyle.solidLine,
                              indicatorStyleBuilder: (context, index) =>
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
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
