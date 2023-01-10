// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';

import '../../auth/provider/user_id_provider.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/blackout_models/blackout.dart';
import '../../provider/appointment_page/appointment_upload_provider.dart';
import '../../provider/blackout_provider/blackout_provider.dart';
import '../../widgets/animations/small_error_animation_view.dart';
import '../../widgets/animations/small_loading_animation_view.dart';

class blackOutPage extends ConsumerStatefulWidget {
  const blackOutPage({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _blackOutPageState();
  // @override
  // _blackOutPageState createState() => _blackOutPageState();
}

class _blackOutPageState extends ConsumerState<blackOutPage> {
  String? dropDownValue;
  DataService service = DataService();
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedDayName;
  List<String> dayname = [
    ("Monday"),
    ("Tuesday"),
    ("Wednesday"),
    ("Thursday"),
    ("Friday"),
    ("Saturday"),
    ("Sunday"),
  ];
  String? selectedDay;
  int? idDay;
  String? nameday;
  String? practionerId;
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   selectedDayName = dayname[0];
  // }

  @override
  Widget build(BuildContext context) {
    final userUid = ref.watch(userIdProvider);
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
                                style: FlutterFlowTheme.of(context).subtitle1,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: DropdownButton(
                                  value: selectedDayName,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedDayName = newValue.toString();
                                    });
                                  },
                                  items: dayname.map((dayNames) {
                                    int index = dayname.indexOf(dayNames) + 1;
                                    return new DropdownMenuItem(
                                      value: index.toString(),
                                      child: new Text(
                                        dayNames.toString(),
                                        style:
                                            new TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),

                                // Consumer(builder: (context, ref, child) {
                                //   final blackoutDay =
                                //       ref.watch(blackoutProvider);
                                //   return blackoutDay.when(
                                //     data: (data) {
                                //       return DropdownButton2(
                                //         value: selectedDay,
                                //         items: List.generate(
                                //           data.length,
                                //           (index) => DropdownMenuItem(
                                //             value:
                                //                 data.elementAt(index).valueId,
                                //             child: Text(
                                //               data
                                //                   .elementAt(index)
                                //                   .valueName
                                //                   .toString(),
                                //               style: const TextStyle(
                                //                 fontSize: 14,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         onChanged: (value) {
                                //           // selectedLocation = value;
                                //           ref
                                //               .read(selectedBlackoutProvider
                                //                   .notifier)
                                //               .changeBlackout(value.toString());

                                //           selectedDay = value;
                                //           //Do something when changing the item if you want.
                                //         },
                                //         hint: Text("Please select..."),
                                //         icon: const Icon(
                                //           Icons.format_list_numbered,
                                //         ),
                                //         iconSize: 14,
                                //       );
                                //     },
                                //     error: (error, stackTrace) {
                                //       return const SmallErrorAnimationView();
                                //     },
                                //     loading: () {
                                //       return const SmallLoadingAnimationView();
                                //     },
                                //   );
                                // }),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    print(selectedDayName);
                                    // DayName dayNameData = DayName(
                                    //   id: selectedDayName.id,
                                    //   name: selectedDayName.name.toString(),
                                    //   practionerId: FirebaseAuth
                                    //       .instance.currentUser?.uid
                                    //       .toString(),
                                    // );
                                    await service.addBlackout(
                                        selectedDayName.toString(),
                                        FirebaseAuth.instance.currentUser!.uid);

                                    print('Button pressed ...');
                                  },
                                  text: 'Deactivated',
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
