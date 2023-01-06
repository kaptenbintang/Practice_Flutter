// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/appointment/appointment.dart';
import 'package:login_uix_firebase/provider/main_page/appointment2_provider.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/responsive.dart';
import '../../route.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';

class historyBookingDesktop extends ConsumerWidget {
  const historyBookingDesktop({super.key});

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
    TextEditingController? searchController;
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
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
                                  Navigator.pushNamed(context,
                                      RouteName.historyBookingRiverpod);
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
                                controller: searchController,
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
                Container(
                  width: screenWidth,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20),
                            screenWidth / (width / 20)),
                        child: Text(
                          'My Booking History',
                          style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: screenWidth / (width / 24)),
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final appointments =
                              ref.watch(userAppointmentProvider2);
                          return appointments.when(data: (data) {
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final appointmentData =
                                        data.elementAt(index);
                                    return tableDepanAppointment(
                                        context, appointmentData);
                                  });
                            } else {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20),
                                    screenWidth / (width / 20)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'lib/images/noappointment.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20),
                                          screenWidth / (width / 20)),
                                      child: Text(
                                        'You haven\'t an appointment yet',
                                        style: FlutterFlowTheme.of(context)
                                            .subtitle2,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          }, error: (error, stackTrace) {
                            print(error);
                            return const ErrorAnimationView();
                          }, loading: () {
                            return const LoadingAnimationView();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableDepanAppointment(BuildContext context, Appointment data) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    String isComplete = data.statusAppointment;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20),
          screenWidth / (width / 20)),
      child: Container(
        height: screenWidth / (width / 100),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          borderRadius: BorderRadius.circular(screenWidth / (width / 20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Created at
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Created At',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: Text(
                    data.createdAt.toString(),
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18)),
                  ),
                ),
              ],
            ),
            //Date time booking
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Date/Time Booking',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: Text(
                    data.date,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18)),
                  ),
                ),
              ],
            ),
            //Services
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Services',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: Text(
                    data.services.toString(),
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18)),
                  ),
                ),
              ],
            ),
            //Practioner
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Practioner Name',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: Text(
                    data.practionerName,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18)),
                  ),
                ),
              ],
            ),
            //Location
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Location',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: Text(
                    data.location.toString(),
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 18)),
                  ),
                ),
              ],
            ),
            //Status
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 20),
                      screenWidth / (width / 10)),
                  child: Text(
                    'Status',
                    style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 20)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      screenWidth / (width / 20),
                      0,
                      screenWidth / (width / 20),
                      0),
                  child: isComplete == "Complete"
                      ? Text(
                          data.statusAppointment.toString(),
                          style: FlutterFlowTheme.of(context)
                              .subtitle1
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryColor,
                                fontSize: screenWidth / (width / 18),
                              ),
                        )
                      : Text(
                          data.statusAppointment.toString(),
                          style: FlutterFlowTheme.of(context)
                              .subtitle1
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).alternate,
                                fontSize: screenWidth / (width / 18),
                              ),
                        ),

                  // Text(
                  //   data.statusAppointment.toString(),
                  //   style: FlutterFlowTheme.of(context).subtitle1.override(
                  //         fontFamily: 'Poppins',
                  //         color: FlutterFlowTheme.of(context).secondaryColor,
                  //       ),
                  // ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
