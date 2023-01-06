// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/dimensions.dart';
import '../../model/appointment/appointment.dart';
import '../../model/practioner_models/practioner.dart';
import '../../provider/main_page/appointment2_provider.dart';
import '../../route.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';
import '../appointment_page_riverpod_ver2.dart';

class historyBookingMobile extends ConsumerWidget {
  const historyBookingMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Header
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.height10,
                    right: Dimensions.height10,
                    bottom: Dimensions.height20),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius15),
                      bottomRight: Radius.circular(Dimensions.radius15),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width08),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Home navigation
                        InkWell(
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
                                    fontSize: Dimensions.font12),
                          ),
                        ),
                        //Profile navigation
                        InkWell(
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
                                    fontSize: Dimensions.font12),
                          ),
                        ),
                        //Booking History
                        InkWell(
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
                                    fontSize: Dimensions.font12),
                          ),
                        ),

                        //Logo Image
                        Image.asset(
                          'lib/images/Logo-Slogan-BL-H400-W1080.png',
                          width: Dimensions.width100,
                          height: Dimensions.height20 * 2,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Content
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: Dimensions.radius12,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius30),
                    bottomRight: Radius.circular(Dimensions.radius30),
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          Dimensions.height10,
                          Dimensions.height10,
                          Dimensions.height10,
                          Dimensions.height10),
                      child: Text(
                        'My Booking History',
                        style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Poppins', fontSize: Dimensions.font20),
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
                                  final appointmentData = data.elementAt(index);
                                  return tableDepanAppointment(
                                      context, appointmentData);
                                });
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  Dimensions.height10,
                                  Dimensions.height10,
                                  Dimensions.height10,
                                  Dimensions.height10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'lib/images/noappointment.png',
                                      width: Dimensions.width100 * 1.5,
                                      height: Dimensions.height100 * 1.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.height10,
                                        Dimensions.height10,
                                        Dimensions.height10,
                                        Dimensions.height10),
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

              //Footer
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height20),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width08),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Title
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height08),
                          child: Text(
                            'Your Happiness Center',
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                        //Subtitle
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height08),
                          child: Text(
                            '#ReachingOutIsAStrength',
                            style: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor),
                          ),
                        ),
                        //Body
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height08),
                          child: Text(
                            'Get support by email, phone or chat, set up a meeting, or make a reservation for a session to discuss your needs.',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: Dimensions.height10,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Icon Info
                        Padding(
                          padding: EdgeInsets.only(top: Dimensions.height08),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Location
                              Expanded(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: Dimensions.iconSize24,
                                ),
                              ),
                              //Call
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ),
                              //Email
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ),
                              //Admin Hours
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10),
                                  child: Icon(
                                    Icons.access_time,
                                    color: Colors.black,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ),
                              //Session Hours
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10,
                                      Dimensions.height10),
                                  child: Icon(
                                    Icons.chat_bubble_outline_outlined,
                                    color: Colors.black,
                                    size: Dimensions.iconSize24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Title Info
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.height08),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  'Stop By',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Call Us',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Email Us',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Admin Hours',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Session Hours',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Info
                        Padding(
                          padding: EdgeInsets.only(bottom: Dimensions.height08),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  'Sunway Geo Avenue\nE-02-02 Jalan Lagoon Selatan',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '+603.5612.0020\n+6014.718.8213',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'hello@relationary.com',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Everyday\n9:00am to 6:00pm',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Everyday\n9:30am to 10:00pm',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Watermark
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height08),
                          child: Text(
                            '© 2022-2023 Blue Harmony',
                            style: FlutterFlowTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: Dimensions.font12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tableDepanAppointment(BuildContext context, Appointment data) {
    String isComplete = data.statusAppointment;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(Dimensions.height10,
          Dimensions.height10, Dimensions.height10, Dimensions.height10),
      child: Container(
        height: Dimensions.height100 * 2.5,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).lineColor,
          borderRadius: BorderRadius.circular(Dimensions.height10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Created at
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Created At',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: Text(
                      data.createdAt.toString(),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ],
            ),
            //Date time booking
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Date/Time Booking',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: Text(
                      data.date,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ],
            ),
            //Services
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Services',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: Text(
                      data.services.toString(),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ],
            ),
            //Practioner
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Practioner Name',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: Text(
                      data.practionerName,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ],
            ),
            //Location
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Location',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: Text(
                      data.location.toString(),
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.font14),
                    ),
                  ),
                ),
              ],
            ),
            //Status
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height10,
                        Dimensions.height05),
                    child: Text(
                      'Status',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins', fontSize: Dimensions.height10),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        Dimensions.height10, 0, Dimensions.height10, 0),
                    child: isComplete == "Complete"
                        ? Text(
                            data.statusAppointment.toString(),
                            style:
                                FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      fontSize: Dimensions.font14,
                                    ),
                          )
                        : Text(
                            data.statusAppointment.toString(),
                            style: FlutterFlowTheme.of(context)
                                .subtitle1
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: Dimensions.font14,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
