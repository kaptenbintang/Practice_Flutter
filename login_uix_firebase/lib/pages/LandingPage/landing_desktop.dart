// ignore_for_file: unused_import, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:login_uix_firebase/route.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageDesktopWidget extends StatelessWidget {
  LandingPageDesktopWidget({Key? key}) : super(key: key);

  PageController? pageViewController;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double maxWidth = 1920;
    return Align(
      alignment: AlignmentDirectional(0.5, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: _width / (maxWidth / 500),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      scrollDirection: Axis.horizontal,
                      children: [
                        //Pageview0
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/business.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.03, -0.51),
                              child: SelectionArea(
                                  child: Text(
                                'Business',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF68EBDC),
                                      fontSize: _width / (maxWidth / 50),
                                    ),
                              )),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Container(
                                height: _width / (maxWidth / 150),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'EAP Programs',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Coching Services',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Training  Programs',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
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
                        //Pageview1
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/family.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.03, -0.51),
                              child: SelectionArea(
                                  child: Text(
                                'Personal',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF68EBDC),
                                      fontSize: _width / (maxWidth / 50),
                                    ),
                              )),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 1),
                              child: Container(
                                height: _width / (maxWidth / 150),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Psychotherapy & Counseling',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Assessment Services',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          text: 'Education & Development',
                                          options: FFButtonOptions(
                                            width: _width / (maxWidth / 280),
                                            height: _width / (maxWidth / 40),
                                            color: Color(0xFFD9DD12),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Color(0xFF469C92),
                                                      fontSize: _width /
                                                          (maxWidth / 18),
                                                    ),
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: 8,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: _width / (maxWidth / 10),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
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
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: smooth_page_indicator.SmoothPageIndicator(
                        controller: pageViewController ??=
                            PageController(initialPage: 0),
                        count: 2,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) {
                          pageViewController!.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        effect: smooth_page_indicator.ExpandingDotsEffect(
                          expansionFactor: 2,
                          spacing: 8,
                          radius: 16,
                          dotWidth: _width / (maxWidth / 30),
                          dotHeight: _width / (maxWidth / 30),
                          dotColor: Color(0xFF292121),
                          activeDotColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Container(
                height: _width / (maxWidth / 330),
                decoration: BoxDecoration(
                  color: Color(0x00FFFFFF),
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Container(
                            width: _width / (maxWidth / 350),
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.05, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Icon(
                                    Icons.settings_outlined,
                                    color: Color(0xFFD9DD12),
                                    size: _width / (maxWidth / 80),
                                  ),
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: SelectionArea(
                                        child: Text(
                                      'Highly-Qualified Diverse Wellbeing Specialists',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: _width / (maxWidth / 28),
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Container(
                            width: _width / (maxWidth / 350),
                            decoration: BoxDecoration(
                              color: Color(0xFF26AECA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.05, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Icon(
                                    Icons.image_search,
                                    color: Color(0xFFD9DD12),
                                    size: _width / (maxWidth / 80),
                                  ),
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: SelectionArea(
                                        child: Text(
                                      'Highly-Qualified Diverse Wellbeing Specialists',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: _width / (maxWidth / 28),
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Container(
                            width: _width / (maxWidth / 350),
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.05, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite_rounded,
                                    color: Color(0xFFD9DD12),
                                    size: _width / (maxWidth / 80),
                                  ),
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: SelectionArea(
                                        child: Text(
                                      'Highly-Qualified Diverse Wellbeing Specialists',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: _width / (maxWidth / 28),
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Container(
                            width: _width / (maxWidth / 350),
                            decoration: BoxDecoration(
                              color: Color(0xFF26AECA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.05, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Icon(
                                    Icons.stairs_outlined,
                                    color: Color(0xFFD9DD12),
                                    size: _width / (maxWidth / 80),
                                  ),
                                  Container(
                                    width: 100,
                                    height: _width / (maxWidth / 10),
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: SelectionArea(
                                        child: Text(
                                      'Highly-Qualified Diverse Wellbeing Specialists',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: _width / (maxWidth / 28),
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0.93),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'See Upcoming Events',
                        options: FFButtonOptions(
                          width: _width / (maxWidth / 350),
                          height: _width / (maxWidth / 45),
                          color: Color(0xFFD9DD12),
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF225E6A),
                                  fontSize: _width / (maxWidth / 20)),
                          elevation: 10,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Container(
                      width: _width / (maxWidth / 350),
                      height: _width / (maxWidth / 350),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              Image.asset(
                                'assets/images/autism.png',
                                width: _width / (maxWidth / 120),
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                'Thriving with Neurodiversity and Different Abilities',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 15),
                                    ),
                              )),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                child: SelectionArea(
                                    child: Text(
                                  'Autism Spectrum, ADHD, Giftedness, Learning Disabilities — Dyslexia, Dysgraphia, Dyscalculia, Communication Delays, Twice Exceptional, Hearing & Visual Impairments, Early Intervention Supports. ',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 12),
                                      ),
                                )),
                              ),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.92, -0.96),
                            child: SelectionArea(
                                child: Text(
                              'FlippableCard',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    fontSize: 12,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Container(
                    width: _width / (maxWidth / 350),
                    height: _width / (maxWidth / 350),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            Image.asset(
                              'assets/images/Health.png',
                              width: _width / (maxWidth / 130),
                              height: _width / (maxWidth / 130),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Health and Fitness Concerns',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                            )),
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Pain, Migraine, Sleep and Wake Disorders like Insomnia, Chronic Illness, Weight Management, Fertility Struggles, and Fatigue',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 10),
                                  ),
                            )),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.92, -0.96),
                          child: SelectionArea(
                              child: Text(
                            'FlippableCard',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontSize: 11,
                                    ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      width: _width / (maxWidth / 350),
                      height: _width / (maxWidth / 350),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              Image.asset(
                                'assets/images/Home.png',
                                width: _width / (maxWidth / 120),
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                'Relationship and Family Concerns',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 15),
                                    ),
                              )),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                'Parent-Child Conflicts, Family Arguments, Separation, Divorce, Discernment, Infidelity, Blending Families, Sexual Concerns',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 12),
                                    ),
                              )),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.92, -0.96),
                            child: SelectionArea(
                                child: Text(
                              'FlippableCard',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    fontSize: 12,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Container(
                    width: _width / (maxWidth / 350),
                    height: _width / (maxWidth / 350),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            Image.asset(
                              'assets/images/Reports.png',
                              width: _width / (maxWidth / 130),
                              height: _width / (maxWidth / 130),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Psychological and Educational Diagnostic Assessments',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                            )),
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Developmental and Academic Worries, and Psycho-educational Assessment and Intervention Supports. ',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 10),
                                  ),
                            )),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.92, -0.96),
                          child: SelectionArea(
                              child: Text(
                            'FlippableCard',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontSize: 12,
                                    ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      width: _width / (maxWidth / 350),
                      height: _width / (maxWidth / 350),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              Image.asset(
                                'assets/images/Low.png',
                                width: _width / (maxWidth / 120),
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                'Adjustment and Situation Concerns',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 15),
                                    ),
                              )),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                              SelectionArea(
                                  child: Text(
                                'COVID-19 Stress, Fatigue, and Worries; Student/Academic Stress and Adjustment, Crisis Management, Moving, Migration and Expatriate Concerns, Life Stage Transitions, and Grief and Loss.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: _width / (maxWidth / 12),
                                    ),
                              )),
                              Container(
                                width: 100,
                                height: _width / (maxWidth / 10),
                                decoration: BoxDecoration(
                                  color: Color(0x00FFFFFF),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.92, -0.96),
                            child: SelectionArea(
                                child: Text(
                              'FlippableCard',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                    fontSize: 12,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Container(
                    width: _width / (maxWidth / 350),
                    height: _width / (maxWidth / 350),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).tertiaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            Image.asset(
                              'assets/images/addiction.png',
                              width: _width / (maxWidth / 130),
                              height: _width / (maxWidth / 130),
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Clinical and Psychiatric Concerns',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                            )),
                            Container(
                              width: 100,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Trauma and PTSD, Depression, Self-Harm Thoughts, Bipolar and Related Conditions, Anxiety and Panic, OCD, Feeding and Eating Disorders, Dissociation, Personality Disorders, Schizophrenia Spectrum Conditions Dementia, Substance Use, and Behavioral Addictions (Gambling/Shopping/Internet/Porn, etc.).',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: _width / (maxWidth / 10),
                                  ),
                            )),
                            Container(
                              width: 100,
                              height: _width / (maxWidth / 10),
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.92, -0.96),
                          child: SelectionArea(
                              child: Text(
                            'FlippableCard',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontSize: 12,
                                    ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _width / (maxWidth / 350),
                  height: _width / (maxWidth / 350),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 100,
                        height: _width / (maxWidth / 10),
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      Image.asset(
                        'assets/images/EAP.png',
                        width: _width / (maxWidth / 120),
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: 100,
                        height: _width / (maxWidth / 10),
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      SelectionArea(
                          child: Text(
                        'Career and Workplace Concerns',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              fontSize: _width / (maxWidth / 15),
                            ),
                      )),
                      Container(
                        width: 100,
                        height: _width / (maxWidth / 10),
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      SelectionArea(
                          child: Text(
                        'Career Interest Assessments, Identify Career Passion, Lost Passion at Work, Need Coaching for Promotion Success and Leadership Development, Unemployed, Toxic Work Environment or Supervisor, Career Change',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: _width / (maxWidth / 12),
                            ),
                      )),
                      Container(
                        width: 100,
                        height: _width / (maxWidth / 10),
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              height: _width / (maxWidth / 30),
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
            ),
            Container(
              width: 100,
              height: _width / (maxWidth / 30),
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SelectionArea(
                    child: Text(
                  'Getting Started is Easy',
                  style: FlutterFlowTheme.of(context).title1.override(
                      fontFamily: 'Roboto Mono',
                      fontSize: _width / (maxWidth / 30)),
                )),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(50, 20, 50, 20),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      //list1
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
                        child: Container(
                          width: _width / (maxWidth / 120),
                          height: _width / (maxWidth / 100),
                          decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.grey)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: Icon(
                                  Icons.mark_chat_read,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  size: _width / (maxWidth / 50),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Book a Free Consultation',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: _width / (maxWidth / 25),
                                        fontWeight: FontWeight.w600,
                                      ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Our free consultations are very popular,\nplease check back daily for new slots.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //list2
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
                        child: Container(
                          width: _width / (maxWidth / 120),
                          height: _width / (maxWidth / 100),
                          decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.grey)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  size: _width / (maxWidth / 50),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Make an Appointment',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: _width / (maxWidth / 25),
                                        fontWeight: FontWeight.w600,
                                      ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Set an official date and time at which to\nmeet one of our practitioners. ',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //list3
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
                        child: Container(
                          width: _width / (maxWidth / 120),
                          height: _width / (maxWidth / 150),
                          decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.grey)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  size: _width / (maxWidth / 50),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Begin your 1st Session!',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Roboto Mono',
                                        fontSize: _width / (maxWidth / 25),
                                        fontWeight: FontWeight.w600,
                                      ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    _width / (maxWidth / 10),
                                    0,
                                    _width / (maxWidth / 10),
                                    0),
                                child: SelectionArea(
                                    child: Text(
                                  'Your therapist will need to know why \nyou’re seeking therapy. They may ask what\n kinds of needs or issues you’d like to address in \nyour treatment together as well as what you’ve\n done to manage your mental health in the \npast.',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        fontSize: _width / (maxWidth / 15),
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Call button
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Book a free phone consultation',
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _width / (maxWidth / 8.0)),
                      child: Icon(
                        Icons.phone,
                        size: _width / (maxWidth / 20),
                      ),
                    ),
                    options: FFButtonOptions(
                      width: _width / (maxWidth / 350),
                      height: _width / (maxWidth / 50),
                      color: FlutterFlowTheme.of(context).primaryBtnText,
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: 'Oswald',
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            fontSize: _width / (maxWidth / 20),
                          ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        width: 1,
                      ),
                      borderRadius: 0,
                    ),
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
