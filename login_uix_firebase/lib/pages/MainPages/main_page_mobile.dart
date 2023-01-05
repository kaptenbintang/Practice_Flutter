// ignore_for_file: prefer_const_constructors

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/database_service.dart';
import '../../model/practioner_data.dart';
import '../../provider/main_page/practioner_provider.dart';
import '../../route.dart';
import '../../widgets/animations/empty_contents_with_text_animation_view.dart';
import '../../widgets/animations/error_animation_view.dart';
import '../../widgets/animations/loading_animation_view.dart';
import '../../widgets/practioners/practioners_grid_view.dart';
import '../detail_practioner_page.dart';
import 'main_page_desktop_riverpod.dart';

class mainPageMobile extends ConsumerWidget {
  const mainPageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    TextEditingController? textController;
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
                                context, MainPageDesktopRiverpod.routeName);
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Search Text field
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: SizedBox(
                        height: Dimensions.height30,
                        width: Dimensions.width100 * 2,
                        child: TextFormField(
                          controller: textController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Search Something here..',
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            contentPadding:
                                EdgeInsets.all(Dimensions.font16 / 2),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height20),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                  fontFamily: 'Poppins',
                                  fontSize: Dimensions.font14),
                        ),
                      ),
                    ),

                    //Title
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          top: Dimensions.height10,
                          bottom: Dimensions.height10),
                      child: Text(
                        'Begin your 1st Session!',
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                    ),
                    //Text
                    Padding(
                      padding: EdgeInsets.all(
                        Dimensions.width10,
                      ),
                      child: Text(
                        'We believe anyone can attain true happiness, whether adults, children, youth, male and female.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    //Icon Row
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'lib/images/Adjustment-Icon-7.png',
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.06,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'lib/images/7.png',
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.06,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'lib/images/9.png',
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.06,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'lib/images/10.png',
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.06,
                            fit: BoxFit.cover,
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
                                height: Dimensions.height100 * 6,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: Dimensions.font12,
                                      color: Color(0x33000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(Dimensions.radius30),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius30),
                                    topLeft:
                                        Radius.circular(Dimensions.radius30),
                                    topRight:
                                        Radius.circular(Dimensions.radius30),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(Dimensions.height20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            Dimensions.height10,
                                            0,
                                            Dimensions.height10,
                                            Dimensions.height10),
                                        child: Text(
                                          'Practioner',
                                          textAlign: TextAlign.justify,
                                          style: FlutterFlowTheme.of(context)
                                              .title1
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize:
                                                      Dimensions.font12 * 2),
                                        ),
                                      ),
                                      data.isNotEmpty
                                          ? PractionersGridView(
                                              practioners: data)
                                          : EmptyContentsWithTextAnimationView(
                                              text: "no avaible practioners",
                                            ),
                                    ],
                                  ),
                                ));
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
                    //On going Appointment List
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Dimensions.height08),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: Dimensions.font12,
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
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      26,
                                      Dimensions.height20,
                                      Dimensions.height20,
                                      20),
                                  child: Text(
                                    'On going appointment',
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  Dimensions.height20,
                                  Dimensions.height20,
                                  Dimensions.height20,
                                  20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'lib/images/noappointment.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, Dimensions.height20, 0, 0),
                                      child: Text(
                                        'No Appointment',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
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
              ),
              //Footer
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height08),
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
