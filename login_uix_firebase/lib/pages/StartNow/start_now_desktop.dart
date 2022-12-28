// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_checkbox_group.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../helper/responsive.dart';

class StartNowDesktop extends StatefulWidget {
  const StartNowDesktop({super.key});

  @override
  State<StartNowDesktop> createState() => _StartNowDesktopState();
}

class _StartNowDesktopState extends State<StartNowDesktop> {
  TextEditingController? textController;
  List<String>? checkboxGroupValues;

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

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / (width / 100),
                  height: screenWidth / (width / 175),
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
                        'CONSULTATION SESSION',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 18)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 10),
                            0,
                            screenWidth / (width / 10)),
                        child: Text(
                          'Your Happiness Center',
                          style: FlutterFlowTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              fontSize: screenWidth / (width / 24)),
                        ),
                      ),
                      Text(
                        '#ReachingOutIsAStrength',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 18)),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 10),
                            0,
                            screenWidth / (width / 10)),
                        child: Text(
                          'Once you submit the form, you will get an email to tell you the next steps.\nYou can see one of our practitioners within 24 hours!',
                          textAlign: TextAlign.center,
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
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / (width / 100),
                  height: screenWidth / (width / 170),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 0, screenWidth / (width / 30), 0),
                        child: Container(
                          width: screenWidth / (width / 200),
                          height: screenWidth / (width / 100),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Consultation',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth / (width / 20)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 10),
                            0,
                            screenWidth / (width / 10)),
                        child: Container(
                          width: screenWidth / (width / 400),
                          height: screenWidth / (width / 150),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 10),
                                screenWidth / (width / 10),
                                screenWidth / (width / 10),
                                screenWidth / (width / 10)),
                            child: Text(
                              'We would be delighted to sit with you to help you decide on which service would best fit your current needs. Follow the simple steps below to enable us to have an effective consultation session.  First step, fill the Consultation Application using the buttons below and then, book a 30-minutes Consultation Session.',
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth / (width / 14)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / (width / 100),
                  height: screenWidth / (width / 170),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 0, screenWidth / (width / 30), 0),
                        child: Container(
                          width: screenWidth / (width / 200),
                          height: screenWidth / (width / 100),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/step-1.png',
                                width: screenWidth / (width / 100),
                                height: screenWidth / (width / 100),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 10),
                            0,
                            screenWidth / (width / 10)),
                        child: Container(
                          width: screenWidth / (width / 400),
                          height: screenWidth / (width / 150),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                screenWidth / (width / 10),
                                screenWidth / (width / 10),
                                screenWidth / (width / 10),
                                screenWidth / (width / 10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, screenWidth / (width / 10), 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: screenWidth / (width / 240),
                                          height: screenWidth / (width / 100),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Text(
                                            'Take 15 minutes to tell us about your situation and fill the consultation application.  The more information you share in this application, the more effective the session would be.',
                                            textAlign: TextAlign.justify,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 14)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 10),
                                        0,
                                        screenWidth / (width / 10),
                                        0),
                                    child: Container(
                                      width: screenWidth / (width / 100),
                                      height: screenWidth / (width / 50),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(
                                            screenWidth / (width / 10)),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Consultation Form',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    fontSize: screenWidth /
                                                        (width / 14)),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / (width / 100),
                  height: screenWidth / (width / 170),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 0, screenWidth / (width / 30), 0),
                        child: Container(
                          width: screenWidth / (width / 200),
                          height: screenWidth / (width / 100),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/step-2.png',
                                width: screenWidth / (width / 100),
                                height: screenWidth / (width / 100),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            screenWidth / (width / 10),
                            0,
                            screenWidth / (width / 10)),
                        child: Container(
                          width: screenWidth / (width / 400),
                          height: screenWidth / (width / 150),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0,
                                screenWidth / (width / 10),
                                0,
                                screenWidth / (width / 10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        screenWidth / (width / 10),
                                        0,
                                        screenWidth / (width / 10)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10),
                                            screenWidth / (width / 10)),
                                        child: Text(
                                          'An email will be sent to you to book a Consultation Session with one of our practitioners to provide you with answers to your inquiries.',
                                          textAlign: TextAlign.justify,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
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
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / (width / 100),
                  height: screenWidth / (width / 220),
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
                      Expanded(
                        child: Container(
                          width: screenWidth / (width / 500),
                          height: screenWidth / (width / 100),
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0,
                                            screenWidth / (width / 5),
                                            0,
                                            screenWidth / (width / 5)),
                                        child: Text(
                                          'Subscribe To Our Announcement List',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        screenWidth / (width / 5),
                                        0,
                                        screenWidth / (width / 5)),
                                    child: Container(
                                      width: screenWidth / (width / 200),
                                      decoration: BoxDecoration(),
                                      child: TextFormField(
                                        controller: textController,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Full Name',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  screenWidth / (width / 4)),
                                              topRight: Radius.circular(
                                                  screenWidth / (width / 4)),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  screenWidth / (width / 4)),
                                              topRight: Radius.circular(
                                                  screenWidth / (width / 4)),
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  screenWidth / (width / 4)),
                                              topRight: Radius.circular(
                                                  screenWidth / (width / 4)),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  screenWidth / (width / 4)),
                                              topRight: Radius.circular(
                                                  screenWidth / (width / 4)),
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  screenWidth / (width / 10),
                                                  screenWidth / (width / 10),
                                                  screenWidth / (width / 10),
                                                  screenWidth / (width / 10)),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  screenWidth / (width / 14),
                                            ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        screenWidth / (width / 5),
                                        0,
                                        screenWidth / (width / 5)),
                                    child: Container(
                                      width: screenWidth / (width / 200),
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Inform me by',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                    fontFamily: 'Poppins',
                                                    fontSize: screenWidth /
                                                        (width / 14)),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0,
                                                    screenWidth / (width / 10),
                                                    screenWidth / (width / 10),
                                                    screenWidth / (width / 10)),
                                            child: FlutterFlowCheckboxGroup(
                                              options: ['Email', 'Whatsapp'],
                                              onChanged: (val) => setState(() =>
                                                  checkboxGroupValues = val),
                                              activeColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              checkColor: Colors.white,
                                              checkboxBorderColor:
                                                  Color(0xFF95A1AC),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: screenWidth /
                                                            (width / 12),
                                                      ),
                                              initiallySelected:
                                                  checkboxGroupValues,
                                              checkboxBorderRadius:
                                                  BorderRadius.circular(
                                                      screenWidth /
                                                          (width / 5)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 10),
                                    0,
                                    screenWidth / (width / 10),
                                    screenWidth / (width / 10)),
                                child: Container(
                                  width: screenWidth / (width / 100),
                                  height: screenWidth / (width / 30),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth / (width / 5)),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 5),
                                        screenWidth / (width / 5)),
                                    child: Text(
                                      'Subscribe',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            fontSize:
                                                screenWidth / (width / 14),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
