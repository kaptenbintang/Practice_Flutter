// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/responsive.dart';

class blackOutPage extends StatefulWidget {
  const blackOutPage({Key? key}) : super(key: key);

  @override
  _blackOutPageState createState() => _blackOutPageState();
}

class _blackOutPageState extends State<blackOutPage> {
  String? dropDownValue;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedDay;
  @override
  void dispose() {
    _unfocusNode.dispose();
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
      key: scaffoldKey,
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
            'Blackout',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Text(
                            'Disable your available date',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 30,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Note: Each day selected will be deactivated',
                                    style: FlutterFlowTheme.of(context).title1,
                                  ),
                                  Text(
                                    '1 : Monday\n2: Tuesday\n3: Wednesday\n4: Thursday\n5: Friday\n6: Saturday\n7: Sunday',
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Select day:',
                                style: FlutterFlowTheme.of(context).title1,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: DropdownButton2(
                                  value: selectedDay,
                                  items: [
                                    DropdownMenuItem(
                                      value: '1',
                                      child: Text('Monday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2',
                                      child: Text('Tuesday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '3',
                                      child: Text('Wednesday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '4',
                                      child: Text('Thursday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '5',
                                      child: Text('Friday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '6',
                                      child: Text('Saturday'),
                                    ),
                                    DropdownMenuItem(
                                      value: '7',
                                      child: Text('Sunday'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      value = selectedDay;
                                    });
                                  },
                                  hint: Text("Please select"),
                                  icon: const Icon(
                                    Icons.format_list_numbered,
                                  ),
                                  iconSize: 14,
                                ),
                              ),
                              // DropdownButtonFormField2(
                              //   // icon: const Icon(
                              //   //   Icons.arrow_drop_down,
                              //   //   color: Colors.black45,
                              //   // ),
                              //   // iconSize: 30,
                              //   // buttonHeight: 60,
                              //   // buttonPadding: const EdgeInsets.only(
                              //   //     left: 20, right: 10),
                              //   dropdownDecoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(15),
                              //   ),
                              //   decoration: InputDecoration(
                              //     isDense: true,
                              //     contentPadding: EdgeInsets.zero,
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(8),
                              //       borderSide: BorderSide(
                              //         color: FlutterFlowTheme.of(context)
                              //             .primaryText,
                              //         width: 1,
                              //       ),
                              //     ),
                              //   ),
                              //   hint: Text(
                              //     'Please select',
                              //     style: FlutterFlowTheme.of(context).subtitle1,
                              //   ),
                              //   style: FlutterFlowTheme.of(context).subtitle1,
                              //   items: [
                              //     DropdownMenuItem(
                              //       value: '1',
                              //       child: Text('Monday'),
                              //     ),
                              //     DropdownMenuItem(
                              //       value: '2',
                              //       child: Text('Tuesday'),
                              //     ),
                              //   ],
                              //   onChanged: (value) {
                              //     // selectedCodeorName = value;
                              //     //Do something when changing the item if you want.
                              //   },
                              //   onSaved: (value) {
                              //     // selectedValue = value.toString();
                              //   },
                              // ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Submit',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 35,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 8,
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'Selected day:',
                                    style:
                                        FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'Monday',
                                    style:
                                        FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 30,
                                  borderWidth: 1,
                                  buttonSize: 60,
                                  icon: FaIcon(
                                    FontAwesomeIcons.windowClose,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ],
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
