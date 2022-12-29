import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/responsive.dart';
import '../../model/practioner_models/practioner.dart';
import '../../provider/time_schedule/schedule_provider.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class timeSchedulePage extends StatefulWidget {
  const timeSchedulePage({Key? key}) : super(key: key);

  @override
  _timeSchedulePageState createState() => _timeSchedulePageState();
}

class _timeSchedulePageState extends State<timeSchedulePage> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenWidth / (width / 100)),
        child: AppBar(
          actions: const [],
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: screenWidth / (width / 30),
            borderWidth: 1,
            buttonSize: screenWidth / (width / 50),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: screenWidth / (width / 50),
            ),
            onPressed: () {
              print('IconButton pressed ...');
              Navigator.pop(context);
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0, 0, 0, screenWidth / (width / 14)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        screenWidth / (width / 24), 0, 0, 0),
                    child: Text(
                      'Time Schedule',
                      style: FlutterFlowTheme.of(context).title2.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: screenWidth / (width / 30),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
          ),
          // actions: [],
          centerTitle: true,
          elevation: 2,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    //klobanyak scroll wae
                    child: Consumer(builder: (context, ref, child) {
                      final schedule = ref.watch(timeScheduleProvider);
                      return schedule.when(data: (data) {
                        if (data.isNotEmpty) {
                          final listDay = data.elementAt(0).schedules;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 20),
                                child: Text(
                                  'Edit your time schedule?',
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                      ),
                                ),
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listDay.length,
                                itemBuilder: (context, index) {
                                  final key = listDay.values.elementAt(index);
                                  return tableDepanTimeSchedule(context, key);
                                },
                              ),
                            ],
                          );
                        } else {
                          return const LoadingAnimationView();
                        }
                      }, error: (error, stackTrace) {
                        print(error);
                        return const ErrorAnimationView();
                      }, loading: () {
                        return const LoadingAnimationView();
                      });
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableDepanTimeSchedule(BuildContext context, data) {
    // print(data);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Icon(
                            Icons.date_range_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        Text(
                          data["dayName"].toString(),
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                fontSize: 26,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Icon(
                            Icons.access_time_sharp,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        Text(
                          data["resultTime"].toString(),
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                          child: FlutterFlowIconButton(
                            borderColor:
                                FlutterFlowTheme.of(context).primaryText,
                            borderRadius: 30,
                            borderWidth: 2,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.more_time_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                        Text(
                          'Start Time',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                          child: FlutterFlowIconButton(
                            borderColor:
                                FlutterFlowTheme.of(context).primaryText,
                            borderRadius: 30,
                            borderWidth: 2,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.timer_off_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                        Text(
                          'End Time',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
