import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/dimensions.dart';
import '../../model/practioner_models/practioner.dart';
import '../../route.dart';
import '../appointment_page_riverpod_ver2.dart';

class detailPractionerMobile extends ConsumerWidget {
  final Practioner practioner;
  const detailPractionerMobile(this.practioner, {super.key});

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width08),
                child: Container(
                  width: double.maxFinite,
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Practioner info and pp
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimensions.height20),
                        child: Column(
                          children: [
                            //Practioner Info
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height08),
                              child: Text(
                                practioner.firstName.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font16),
                              ),
                            ),
                            Text(
                              '(Speaks ' +
                                  practioner.languages.toString() +
                                  ')',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .subtitle1
                                  .override(
                                      fontFamily: 'Poppins',
                                      fontSize: Dimensions.font12),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height08),
                              child: Text(
                                practioner.titleMain.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font10),
                              ),
                            ),
                            //Practioner pp
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height08),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                child: Image.asset(
                                  'lib/images/doctor.png',
                                  width: Dimensions.width100 * 1.5,
                                  height: Dimensions.height100 * 1.5,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Detail practioner info
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Subtitle
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  Dimensions.height10,
                                  Dimensions.height10,
                                  0,
                                  Dimensions.height10),
                              child: Text(
                                'Detail Practioner',
                                textAlign: TextAlign.justify,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: Dimensions.font14),
                              ),
                            ),
                            //Detail Practioner grey content
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: Dimensions.height20),
                              child: Container(
                                width: double.maxFinite,
                                height: Dimensions.height100 * 2.5,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).lineColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: Dimensions.radius12,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.height20),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height20,
                                      Dimensions.height20,
                                      Dimensions.height20,
                                      Dimensions.height20),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      //Name
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'Name: ' +
                                              practioner.firstName.toString() +
                                              ' ' +
                                              practioner.lastName.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
                                        ),
                                      ),
                                      //Approach
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'My Approach: ' +
                                              practioner.myApproach.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
                                        ),
                                      ),
                                      //Backgrounds
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'My Backgrounds: ' +
                                              practioner.myBackground
                                                  .toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
                                        ),
                                      ),
                                      //Qualifications
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'My Qualifications: ' +
                                              practioner.myQualifications
                                                  .toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
                                        ),
                                      ),
                                      //Speciality
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'My Specialty: ' +
                                              practioner.mySpecialty.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
                                        ),
                                      ),
                                      //Roles
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'My Roles: ' +
                                              practioner.myRoles.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font10),
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
                      //Make an appointment button
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimensions.height08),
                        child: FFButtonWidget(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentPageRiverpodVersion2(
                                  practioner: practioner,
                                ),
                              ),
                            );
                          },
                          text: 'Make an appointment!',
                          options: FFButtonOptions(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.height20,
                                Dimensions.height20,
                                Dimensions.height20,
                                Dimensions.height20),
                            color: FlutterFlowTheme.of(context).primaryColor,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: Dimensions.font12),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: Dimensions.radius15 / 2,
                          ),
                        ),
                      ),
                    ],
                  ),
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
}
