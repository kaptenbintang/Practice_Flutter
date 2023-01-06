// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/provider/main_page/appointment_provider.dart';
import 'package:login_uix_firebase/provider/main_page/practioner_provider.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:login_uix_firebase/widgets/animations/empty_contents_with_text_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/error_animation_view.dart';
import 'package:login_uix_firebase/widgets/animations/loading_animation_view.dart';
import 'package:login_uix_firebase/widgets/appointments/appointments_grid_view.dart';
import 'package:login_uix_firebase/widgets/practioners/practioners_grid_view.dart';

import '../../helper/responsive.dart';

class MainPageDesktopRiverpod extends ConsumerWidget {
  static const routeName = '/mainPageDesktopRiverpod';

  const MainPageDesktopRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    TextEditingController? textController;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Header /NavigationBar
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth / (width / 100),
                    top: screenWidth / (width / 40),
                    right: screenWidth / (width / 100),
                    bottom: screenWidth / (width / 40)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //Home navigation
                          Padding(
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
                          //Profile navigation
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
                          //Booking History
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
                          //Search Text field
                          SizedBox(
                            height: screenWidth / (width / 50),
                            width: screenWidth / (width / 300),
                            child: TextFormField(
                              controller: textController,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search Something here..',
                                hintStyle:
                                    FlutterFlowTheme.of(context).bodyText2,
                                contentPadding:
                                    EdgeInsets.all(screenWidth / (width / 8)),
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
                    Image.asset(
                      'lib/images/Logo-Slogan-BL-H400-W1080.png',
                      width: screenWidth / (width / 300),
                      height: screenWidth / (width / 60),
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
              ),
              //Title
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 0, 0, screenWidth / (width / 40)),
                child: Text(
                  'Begin your 1st Session!',
                  style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 40),
                      ),
                ),
              ),
              //Text
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    screenWidth / (width / 20),
                    screenWidth / (width / 20),
                    screenWidth / (width / 20),
                    screenWidth / (width / 20)),
                child: Text(
                  'We believe anyone can attain true happiness, whether adults, children, youth, male and female.',
                  textAlign: TextAlign.justify,
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth / (width / 18)),
                ),
              ),
              //Icon Row
              Padding(
                padding: EdgeInsets.all(screenWidth / (width / 20)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / (width / 8)),
                      child: Image.asset(
                        'lib/images/Adjustment-Icon-7.png',
                        width: screenWidth / (width / 100),
                        height: screenWidth / (width / 100),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / (width / 8)),
                      child: Image.asset(
                        'lib/images/7.png',
                        width: screenWidth / (width / 100),
                        height: screenWidth / (width / 100),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / (width / 8)),
                      child: Image.asset(
                        'lib/images/9.png',
                        width: screenWidth / (width / 100),
                        height: screenWidth / (width / 100),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / (width / 8)),
                      child: Image.asset(
                        'lib/images/10.png',
                        width: screenWidth / (width / 100),
                        height: screenWidth / (width / 100),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              //Practioner List
              Consumer(
                builder: (context, ref, child) {
                  final practioners = ref.watch(allPractionersProvider);
                  return practioners.when(
                    data: (data) {
                      return Container(
                        width: double.infinity,
                        height: screenWidth / (width / 600),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: screenWidth / (width / 12),
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft:
                                Radius.circular(screenWidth / (width / 60)),
                            topRight:
                                Radius.circular(screenWidth / (width / 60)),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 50)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    0,
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: Text(
                                  'Practioner',
                                  textAlign: TextAlign.justify,
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 24)),
                                ),
                              ),
                              data.isNotEmpty
                                  ? PractionersGridView(practioners: data)
                                  : EmptyContentsWithTextAnimationView(
                                      text: "no avaible practioners",
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return const ErrorAnimationView();
                    },
                    loading: () {
                      return const LoadingAnimationView();
                    },
                  );
                },
              ),
              //On Going Appointment List
              Consumer(
                builder: (context, ref, child) {
                  final appointments = ref.watch(userAppointmentProvider);
                  return appointments.when(
                    data: (data) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 50)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    0,
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: Text(
                                  'On going appointment',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                          fontFamily: 'Poppins',
                                          fontSize: screenWidth / (width / 24)),
                                ),
                              ),
                              Expanded(
                                  child: data.isNotEmpty
                                      ? AppointmentsGridView(appointments: data)
                                      : Center(
                                          child:
                                              const EmptyContentsWithTextAnimationView(
                                            text: 'You have no appointments',
                                          ),
                                        )),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return const ErrorAnimationView();
                    },
                    loading: () {
                      return const LoadingAnimationView();
                    },
                  );
                },
              ),
              //Footer
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(screenWidth / (width / 60)),
                        topRight: Radius.circular(screenWidth / (width / 60)),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 20),
                                0,
                                screenWidth / (width / 20),
                                screenWidth / (width / 30)),
                            child: Text(
                              'Your Happiness Center',
                              style:
                                  FlutterFlowTheme.of(context).title1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 28),
                                      ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, screenWidth / (width / 20)),
                            child: Text(
                              '#ReachingOutIsAStrength',
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 22),
                                      ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Get support by email, phone or chat, set up a meeting, or make a reservation for a session to discuss your needs.',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 20),
                                    ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.black,
                                        size: screenWidth / (width / 60),
                                      ),
                                    ),
                                    Text(
                                      'Stop By',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                    Text(
                                      'Sunway Geo Avenue\nE-02-02 Jalan Lagoon Selatan',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.black,
                                        size: screenWidth / (width / 60),
                                      ),
                                    ),
                                    Text(
                                      'Call Us',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                    Text(
                                      '+603.5612.0020\n+6014.718.8213',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                        size: screenWidth / (width / 60),
                                      ),
                                    ),
                                    Text(
                                      'Email Us',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                    Text(
                                      'hello@relationary.com',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Icon(
                                        Icons.access_time,
                                        color: Colors.black,
                                        size: screenWidth / (width / 60),
                                      ),
                                    ),
                                    Text(
                                      'Admin Hours',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                    Text(
                                      'Everyday\n9:00am to 6:00pm',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20),
                                  screenWidth / (width / 20)),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Icon(
                                        Icons.chat_bubble_outline_outlined,
                                        color: Colors.black,
                                        size: screenWidth / (width / 60),
                                      ),
                                    ),
                                    Text(
                                      'Session Hours',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 18),
                                          ),
                                    ),
                                    Text(
                                      'Everyday\n9:30am to 10:00pm',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .subtitle1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            '© 2022-2023 Blue Harmony',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: screenWidth / (width / 12),
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
      ),
    );
  }
}
