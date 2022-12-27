// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_checkbox_group.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class StartNowMobile extends StatefulWidget {
  const StartNowMobile({super.key});

  @override
  State<StartNowMobile> createState() => _StartNowMobileState();
}

class _StartNowMobileState extends State<StartNowMobile> {
  TextEditingController? textController;
  List<String>? checkboxGroupValues;
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //Title
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: Dimensions.width100,
                  height: Dimensions.height100 + Dimensions.height10 * 7,
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
                              fontSize: Dimensions.font14,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, Dimensions.height10, 0, Dimensions.height10),
                        child: Text(
                          'Your Happiness Center',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                fontSize: Dimensions.font20,
                              ),
                        ),
                      ),
                      Text(
                        '#ReachingOutIsAStrength',
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              fontSize: Dimensions.font14,
                            ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            Dimensions.width10 / 2,
                            Dimensions.height10,
                            Dimensions.width10 / 2,
                            Dimensions.height10),
                        child: Text(
                          'Once you submit the form, you will get an email to tell you the next steps.\nYou can see one of our practitioners within 24 hours!',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: Dimensions.font10,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //Consultation
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Consultation Circle
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(Dimensions.width10,
                      Dimensions.height10, Dimensions.width10, 0),
                  child: Container(
                    width: Dimensions.width100 * 2,
                    height: Dimensions.height100 * 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Consultation',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).title3.override(
                                fontFamily: 'Poppins',
                                fontSize: Dimensions.font15,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Consultation Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, Dimensions.height10, Dimensions.width10, 0),
                  child: Text(
                    'We would be delighted to sit with you to help you decide on which service would best fit your current needs. Follow the simple steps below to enable us to have an effective consultation session.  First step, fill the Consultation Application using the buttons below and then, book a 30-minutes Consultation Session.',
                    textAlign: TextAlign.justify,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: Dimensions.font12,
                        ),
                  ),
                ),
              ),
            ],
          ),
          //Step 1
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Step 1 Image
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      Dimensions.width10, 0, Dimensions.width10, 0),
                  child: Image.asset(
                    'assets/images/step-1.png',
                    width: Dimensions.width100,
                    height: Dimensions.height100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //Step 1 Content
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Step 1 explaination
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height10, Dimensions.width10, 0),
                      child: Text(
                        'Take 15 minutes to tell us about your situation and fill the consultation application.  The more information you share in this application, the more effective the session would be.',
                        textAlign: TextAlign.justify,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: Dimensions.font12,
                            ),
                      ),
                    ),
                    //Button Consultation Form
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          Dimensions.width10,
                          0,
                          Dimensions.width10,
                          Dimensions.height10 / 10),
                      child: Container(
                        width: Dimensions.width100 + Dimensions.width10 * 5,
                        height: Dimensions.height10 * 3,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height08 / 4),
                          child: Text(
                            'Consultation Form',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: Dimensions.font12,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //Step 2
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //Step 2 Image
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      Dimensions.width10, 0, Dimensions.width10, 0),
                  child: Container(
                    width: Dimensions.width100 * 2,
                    height: Dimensions.height100,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/step-2.png',
                          width: Dimensions.width100,
                          height: Dimensions.height100,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Step 2 Content
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0,
                      Dimensions.height10,
                      Dimensions.width10,
                      Dimensions.height10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Text(
                      'An email will be sent to you to book a Consultation Session with one of our practitioners to provide you with answers to your inquiries.',
                      textAlign: TextAlign.justify,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: Dimensions.font12,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Subscribe
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: Dimensions.width100,
                  height: Dimensions.height100 * 2 + Dimensions.height08 / 4,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset(
                        'assets/images/backgroundImage1.jpg',
                      ).image,
                    ),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius15 / 3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: Dimensions.width100 * 5,
                          height: Dimensions.height100,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    Dimensions.width10, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  Dimensions.height05,
                                                  0,
                                                  Dimensions.height05),
                                          child: Text(
                                            'Subscribe To Our Announcement List',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: Dimensions.font12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          Dimensions.height05,
                                          0,
                                          Dimensions.height05),
                                      child: Container(
                                        width: Dimensions.width100 * 2,
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
                                                    Dimensions.radius20 / 5),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20 / 5),
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
                                                    Dimensions.radius20 / 5),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20 / 5),
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20 / 5),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20 / 5),
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
                                                    Dimensions.radius20 / 5),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20 / 5),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    Dimensions.width10,
                                                    Dimensions.height10,
                                                    Dimensions.width10,
                                                    Dimensions.height10),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: Dimensions.font12,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          Dimensions.height05,
                                          0,
                                          Dimensions.height05),
                                      child: Container(
                                        width: Dimensions.width100 * 2,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Inform me by',
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize:
                                                            Dimensions.font12,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0,
                                                      Dimensions.height10,
                                                      Dimensions.width10,
                                                      Dimensions.height10),
                                              child: FlutterFlowCheckboxGroup(
                                                options: ['Email', 'Whatsapp'],
                                                onChanged: (val) => setState(
                                                    () => checkboxGroupValues =
                                                        val),
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
                                                          fontSize:
                                                              Dimensions.font10,
                                                        ),
                                                initiallySelected:
                                                    checkboxGroupValues,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0,
                                    Dimensions.width20, Dimensions.height10),
                                child: Container(
                                  width: Dimensions.width100,
                                  height: Dimensions.height10 * 3,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15 / 3),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        Dimensions.width10 / 2,
                                        Dimensions.height05,
                                        Dimensions.width10 / 2,
                                        Dimensions.height05),
                                    child: Text(
                                      'Subscribe',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            fontSize: Dimensions.font14,
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
