import 'package:login_uix_firebase/flutter_flow/flutter_flow_theme.dart';
import 'package:login_uix_firebase/flutter_flow/flutter_flow_util.dart';

import 'package:login_uix_firebase/flutter_flow/flutter_flow_widgets.dart';

import 'package:flip_card/flip_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPageMobileWidget extends StatefulWidget {
  const LandingPageMobileWidget({Key? key}) : super(key: key);

  @override
  _LandingPageMobileWidgetState createState() =>
      _LandingPageMobileWidgetState();
}

class _LandingPageMobileWidgetState extends State<LandingPageMobileWidget> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0x00FFFFFF),
      drawer: Drawer(
        elevation: 16,
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
                Container(
                  width: 20,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                SelectionArea(
                    child: Text(
                  'Log In',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.black,
                  size: 40,
                ),
                Container(
                  width: 20,
                  height: 80,
                  decoration: BoxDecoration(),
                ),
                SelectionArea(
                    child: Text(
                  'Start Now',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                )),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.event,
                  color: Colors.black,
                  size: 40,
                ),
                Container(
                  width: 20,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                ),
                SelectionArea(
                    child: Text(
                  'Events',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                )),
              ],
            ),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
              ),
              child: SelectionArea(
                  child: Text(
                'Follow Us',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
              )),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.face,
                  color: Colors.black,
                  size: 40,
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 40,
                ),
                Icon(
                  Icons.photo,
                  color: Colors.black,
                  size: 40,
                ),
                Icon(
                  Icons.ondemand_video,
                  color: Colors.black,
                  size: 40,
                ),
              ],
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: true,
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            automaticallyImplyLeading: true,
            title: SelectionArea(
                child: Text(
              'Welcome',
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                  ),
            )),
            actions: [
              Image.asset(
                'assets/images/Signature-Logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ],
            centerTitle: false,
            elevation: 4,
          )
        ],
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 500,
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                              child: PageView(
                                controller: pageViewController ??=
                                    PageController(initialPage: 0),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/business.png',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.03, -0.51),
                                        child: SelectionArea(
                                            child: Text(
                                          'Personal',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF68EBDC),
                                                fontSize: 50,
                                              ),
                                        )),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 1),
                                        child: Container(
                                          height: 150,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'EAP Programs',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Coching Services',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Training  Programs',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
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
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/family.png',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.03, -0.51),
                                        child: SelectionArea(
                                            child: Text(
                                          'Personal',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF68EBDC),
                                                fontSize: 50,
                                              ),
                                        )),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 1),
                                        child: Container(
                                          height: 150,
                                          child: Stack(
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text:
                                                        'Psychotherapy & Counseling',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Assessment Services',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text:
                                                        'Education & Development',
                                                    options: FFButtonOptions(
                                                      width: 280,
                                                      height: 40,
                                                      color: Color(0xFFD9DD12),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF469C92),
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 10,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child:
                                    smooth_page_indicator.SmoothPageIndicator(
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
                                  effect:
                                      smooth_page_indicator.ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 8,
                                    radius: 16,
                                    dotWidth: 16,
                                    dotHeight: 16,
                                    dotColor: Color(0xFF292121),
                                    activeDotColor: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-0.05, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Icon(
                                    Icons.settings_outlined,
                                    color: Color(0xFFD9DD12),
                                    size: 24,
                                  ),
                                  Container(
                                    width: 15,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Expanded(
                                    child: SelectionArea(
                                        child: Text(
                                      'Highly-Qualified Diverse Wellbeing Specialists',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                            fontSize: 18,
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Icon(
                                  Icons.favorite_outlined,
                                  color: Color(0xFFD9DD12),
                                  size: 24,
                                ),
                                Container(
                                  width: 15,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Expanded(
                                  child: SelectionArea(
                                      child: Text(
                                    'Fostering Lifelong Holistic Wellbeing Globally',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 18,
                                        ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Icon(
                                  Icons.stairs_sharp,
                                  color: Color(0xFFD9DD12),
                                  size: 24,
                                ),
                                Container(
                                  width: 15,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Expanded(
                                  child: SelectionArea(
                                      child: Text(
                                    'Comprehensive Approach Towards Career & Organization Success',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 18,
                                        ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Icon(
                                  Icons.saved_search,
                                  color: Color(0xFFD9DD12),
                                  size: 24,
                                ),
                                Container(
                                  width: 15,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                ),
                                Expanded(
                                  child: SelectionArea(
                                      child: Text(
                                    'Personalized Evidence-Based Approaches to Assessment and Treatment',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 18,
                                        ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                      ),
                      FlipCard(
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        speed: 400,
                        front: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/Low.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                          fontSize: 15,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                          fontSize: 12,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/addiction.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    'Clinical and Psychiatric Concerns',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
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
                                          fontSize: 10,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      FlipCard(
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        speed: 400,
                        front: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/Home.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                          fontSize: 15,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                          fontSize: 12,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/Reports.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    'Psychological and Educational Diagnostic Assessments',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
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
                                          fontSize: 12,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      FlipCard(
                        fill: Fill.fillBack,
                        direction: FlipDirection.HORIZONTAL,
                        speed: 400,
                        front: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/autism.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                          fontSize: 15,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    'Autism Spectrum, ADHD, Giftedness, Learning Disabilities — Dyslexia, Dysgraphia, Dyscalculia, Communication Delays, Twice Exceptional, Hearing & Visual Impairments, Early Intervention Supports. ',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        back: Container(
                          width: 300,
                          height: 300,
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
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/Health.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                    ),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    'Health and Fitness Concerns',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
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
                                          fontSize: 12,
                                        ),
                                  )),
                                  Container(
                                    width: 100,
                                    height: 10,
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
                                      ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Color(0x00FFFFFF),
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            Image.asset(
                              'assets/images/EAP.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Career and Workplace Concerns',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                            )),
                            Container(
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                            SelectionArea(
                                child: Text(
                              'Career Interest Assessments, Identify Career Passion, Lost Passion at Work, Need Coaching for Promotion Success and Leadership Development, Unemployed, Toxic Work Environment or Supervisor, Career Change',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                  ),
                            )),
                            Container(
                              width: 100,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(0x00FFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
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
                                ),
                          )),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 120,
                                height: 260,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0x02FFFFFF),
                                      ),
                                    ),
                                    Icon(
                                      Icons.mark_chat_read,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      size: 25,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Book a Free Consultation',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Roboto Mono',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )),
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Our free consultations are very popular, please check back daily for new slots.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 10,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 260,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0x02FFFFFF),
                                      ),
                                    ),
                                    Icon(
                                      Icons.mark_chat_read,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      size: 25,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Make an Appointment',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Roboto Mono',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )),
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Set an official date and time at which to meet one of our practitioners.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 10,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 260,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(0x02FFFFFF),
                                      ),
                                    ),
                                    Icon(
                                      Icons.mark_chat_read,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      size: 25,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Begin your 1st Session!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Roboto Mono',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )),
                                    Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    SelectionArea(
                                        child: Text(
                                      'Your therapist will need to know why you’re seeking therapy. They may ask what kinds of needs or issues you’d like to address in your treatment together as well as what you’ve done to manage your mental health in the past.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 10,
                                          ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Book a free phone consultation',
                            icon: Icon(
                              Icons.phone,
                              size: 18,
                            ),
                            options: FFButtonOptions(
                              width: 250,
                              height: 50,
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Oswald',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryColor,
                                  ),
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).secondaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
