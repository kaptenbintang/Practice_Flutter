// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';

import '../../flutter_flow/flutter_flow.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/responsive.dart';
import '../../model/practioner_models/practioner.dart';
import '../../provider/time_schedule/schedule_get_provider.dart';
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
  final scaffoldvalue = GlobalKey<ScaffoldState>();
  TextEditingController? textController1;
  TextEditingController? textController2;

  // @override
  // void initState() {
  //   super.initState();
  //   // textController1 = TextEditingController(text: 'From: ' );
  //   // textController2 = TextEditingController(text: 'To: 18.00');
  // }

  @override
  void dispose() {
    _unfocusNode.dispose();
    textController1?.dispose();
    textController2?.dispose();
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
      key: scaffoldvalue,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        actions: const [],
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
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
          padding: EdgeInsets.symmetric(vertical: screenWidth / (width / 12)),
          child: Text(
            'Time Schedule',
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth / (width / 8)),
              child: Container(
                width: ResponsiveWidget.isLargeScreen(context)
                    ? MediaQuery.of(context).size.width * 0.4
                    : double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: screenWidth / (width / 12),
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius:
                      BorderRadius.circular(screenWidth / (width / 20)),
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
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Text(
                                'Edit your time schedule?',
                                style: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 24),
                                    ),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listDay.length,
                              itemBuilder: (context, index) {
                                final value = listDay.values.elementAt(index);
                                final key = listDay.keys.elementAt(index);

                                return tableDepanTimeSchedule(
                                    context, value, key, index);
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
          ),
        ),
      ),
    );
  }

  Widget tableDepanTimeSchedule(BuildContext context, data, key, index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    // print(data);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20)),
      child: Container(
        width: screenWidth / (width / 100),
        height: ResponsiveWidget.isLargeScreen(context)
            ? screenWidth / (width / 120)
            : screenWidth / (width / 180),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryColor,
          borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
          shape: BoxShape.rectangle,
        ),
        child: ResponsiveWidget.isLargeScreen(context)
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth / (width / 4)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 8),
                                    0,
                                    screenWidth / (width / 8),
                                    0),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: screenWidth / (width / 24),
                                ),
                              ),
                              Text(
                                data["dayName"].toString(),
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 26),
                                    ),
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Padding(
                              //     padding:
                              //         EdgeInsetsDirectional.fromSTEB(screenWidth / (width / 10), 0, 0, 0),
                              //     child: Text(
                              //       'Disable this day',
                              //       style: FlutterFlowTheme.of(context)
                              //           .subtitle2
                              //           .override(
                              //             fontFamily: 'Poppins',
                              //             fontSize: screenWidth / (width / 10),
                              //             fontStyle: FontStyle.italic,
                              //             decoration: TextDecoration.underline,
                              //           ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth / (width / 4)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: screenWidth / (width / 160),
                                height: screenWidth / (width / 20),
                                child: TextFormField(
                                  controller: textController1,
                                  autofocus: true,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: 'From: ' +
                                        data["startTime"].toString() +
                                        ",",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.more_time_rounded,
                                      size: screenWidth / (width / 24),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 16),
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / (width / 160),
                                height: screenWidth / (width / 20),
                                child: TextFormField(
                                  controller: textController2,
                                  autofocus: true,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText:
                                        'To: ' + data["endTime"].toString(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            screenWidth / (width / 4)),
                                        topRight: Radius.circular(
                                            screenWidth / (width / 4)),
                                      ),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.timer_off_outlined,
                                      size: screenWidth / (width / 24),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .title2
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 16),
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / (width / 8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(builder: (context, ref, child) {
                                return FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  borderRadius: screenWidth / (width / 30),
                                  borderWidth: 2,
                                  buttonSize: screenWidth / (width / 60),
                                  icon: Icon(
                                    Icons.more_time_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: screenWidth / (width / 30),
                                  ),
                                  onPressed: () async {
                                    var time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                    if (time != null) {
                                      await ref
                                          .read(
                                              editStartTimePractioner.notifier)
                                          .editStartTime(
                                            schedule:
                                                "${time.hour}:${time.minute}",
                                            index: index + 1,
                                          )
                                          .then((value) => ref.refresh(
                                              timeScheduleProvider.future));
                                      // setState(() {
                                      //   textController1?.text =
                                      //       "${time.hour}:${time.minute}";
                                      // });
                                    } else {
                                      print("not selected");
                                    }
                                  },
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth / (width / 4)),
                                child: Text(
                                  'Start Time',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 10),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth / (width / 8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer(builder: (context, ref, child) {
                                return FlutterFlowIconButton(
                                  borderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  borderRadius: screenWidth / (width / 30),
                                  borderWidth: 2,
                                  buttonSize: screenWidth / (width / 60),
                                  icon: Icon(
                                    Icons.timer_off_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: screenWidth / (width / 30),
                                  ),
                                  onPressed: () async {
                                    var time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());

                                    if (time != null) {
                                      await ref
                                          .read(editEndTimePractioner.notifier)
                                          .editEndTime(
                                            schedule:
                                                "${time.hour}:${time.minute}",
                                            index: index + 1,
                                          )
                                          .then((value) => ref.refresh(
                                              timeScheduleProvider.future));
                                      // setState(() {
                                      //   textController1?.text =
                                      //       "${time.hour}:${time.minute}";
                                      // });
                                    } else {
                                      print("not selected");
                                    }
                                  },
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth / (width / 4)),
                                child: Text(
                                  'End Time',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 10),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth / (width / 4)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              screenWidth / (width / 8),
                              0,
                              screenWidth / (width / 8),
                              0),
                          child: Icon(
                            Icons.date_range_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: screenWidth / (width / 24),
                          ),
                        ),
                        Text(
                          data["dayName"].toString(),
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                fontSize: screenWidth / (width / 26),
                              ),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //         EdgeInsetsDirectional.fromSTEB(screenWidth / (width / 10), 0, 0, 0),
                        //     child: Text(
                        //       'Disable this day',
                        //       style: FlutterFlowTheme.of(context)
                        //           .subtitle2
                        //           .override(
                        //             fontFamily: 'Poppins',
                        //             fontSize: screenWidth / (width / 10),
                        //             fontStyle: FontStyle.italic,
                        //             decoration: TextDecoration.underline,
                        //           ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth / (width / 4)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth / (width / 4)),
                          child: SizedBox(
                            width: screenWidth / (width / 150),
                            height: screenWidth / (width / 20),
                            child: TextFormField(
                              controller: textController1,
                              autofocus: true,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'From: ' +
                                    data["startTime"].toString() +
                                    ",",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.more_time_rounded,
                                  size: screenWidth / (width / 24),
                                ),
                              ),
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 16),
                                      ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenWidth / (width / 4)),
                          child: SizedBox(
                            width: screenWidth / (width / 150),
                            height: screenWidth / (width / 20),
                            child: TextFormField(
                              controller: textController2,
                              autofocus: true,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'To: ' + data["endTime"].toString(),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        screenWidth / (width / 4)),
                                    topRight: Radius.circular(
                                        screenWidth / (width / 4)),
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.timer_off_outlined,
                                  size: screenWidth / (width / 24),
                                ),
                              ),
                              style:
                                  FlutterFlowTheme.of(context).title2.override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 16),
                                      ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / (width / 8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(builder: (context, ref, child) {
                              return FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                borderRadius: screenWidth / (width / 30),
                                borderWidth: 2,
                                buttonSize: screenWidth / (width / 60),
                                icon: Icon(
                                  Icons.more_time_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: screenWidth / (width / 30),
                                ),
                                onPressed: () async {
                                  var time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  if (time != null) {
                                    await ref
                                        .read(editStartTimePractioner.notifier)
                                        .editStartTime(
                                          schedule:
                                              "${time.hour}:${time.minute}",
                                          index: index + 1,
                                        )
                                        .then((value) => ref.refresh(
                                            timeScheduleProvider.future));
                                    // setState(() {
                                    //   textController1?.text =
                                    //       "${time.hour}:${time.minute}";
                                    // });
                                  } else {
                                    print("not selected");
                                  }
                                },
                              );
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth / (width / 4)),
                              child: Text(
                                'Start Time',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 10),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth / (width / 8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(builder: (context, ref, child) {
                              return FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                borderRadius: screenWidth / (width / 30),
                                borderWidth: 2,
                                buttonSize: screenWidth / (width / 60),
                                icon: Icon(
                                  Icons.timer_off_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: screenWidth / (width / 30),
                                ),
                                onPressed: () async {
                                  var time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now());

                                  if (time != null) {
                                    await ref
                                        .read(editEndTimePractioner.notifier)
                                        .editEndTime(
                                          schedule:
                                              "${time.hour}:${time.minute}",
                                          index: index + 1,
                                        )
                                        .then((value) => ref.refresh(
                                            timeScheduleProvider.future));
                                    // setState(() {
                                    //   textController1?.text =
                                    //       "${time.hour}:${time.minute}";
                                    // });
                                  } else {
                                    print("not selected");
                                  }
                                },
                              );
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenWidth / (width / 4)),
                              child: Text(
                                'End Time',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 10),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
