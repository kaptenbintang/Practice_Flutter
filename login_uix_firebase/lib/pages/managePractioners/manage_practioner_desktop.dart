// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../helper/responsive.dart';
import '../../model/practioner_data.dart';

class ManagePractionerDesktop extends StatefulWidget {
  const ManagePractionerDesktop({super.key});

  @override
  State<ManagePractionerDesktop> createState() =>
      _ManagePractionerDesktopState();
}

class _ManagePractionerDesktopState extends State<ManagePractionerDesktop> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<PractionerData>>? practionerList;
  Map<String, dynamic>? currentPractionerData;
  List<PractionerData>? retrievedPractionerList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  PractionerData? dataU;

  final _firstNamePractioner = TextEditingController();
  final _lastNamePractioner = TextEditingController();
  final _myApproachPractioner = TextEditingController();
  final _myBackgroundPractioner = TextEditingController();
  final _myQualificationsPractioner = TextEditingController();
  final _mySpecialtyPractioner = TextEditingController();
  final _myRolesPractioner = TextEditingController();
  final _languagesPractioner = TextEditingController();
  final _titleMainPractioner = TextEditingController();
  final _schedulePractioner = TextEditingController();

  String? userId;
  String? firstNameID;
  String? lastNameID;
  String? myApproachID;
  String? myBackgroundID;
  String? myQualificationsID;
  String? mySpecialtyID;
  String? myRolesID;
  String? languagesID;
  String? titleMainID;
  String? schedulePractionerID;
  String? selectedValueClient;
  String? selectedValue;
  int _currentSortColumn = 0;
  bool _isAscending = true;

  List<bool>? selected;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveClientType()).cast<Map<String, dynamic>>();
    practionerList = service.retrievePractionerAll();
    retrievedPractionerList = await service.retrievePractionerAll();
    selected = List<bool>.generate(
        retrievedPractionerList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedPractionerList = await service.retrievePractionerAll();

    setState(() {
      practionerList = service.retrievePractionerAll();
    });
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            screenWidth / (width / 16),
            screenWidth / (width / 16),
            screenWidth / (width / 16),
            screenWidth / (width / 16)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(screenWidth / (width / 16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title and subtitle
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    screenWidth / (width / 16),
                    screenWidth / (width / 16),
                    0,
                    screenWidth / (width / 16)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Poppins',
                          fontSize: screenWidth / (width / 20)),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, screenWidth / (width / 4), 0, 0),
                      child: Text(
                        'Your project status is appearing here.',
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 14)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    screenWidth / (width / 12),
                    0,
                    screenWidth / (width / 12),
                    0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 4),
                          0,
                          screenWidth / (width / 4),
                          screenWidth / (width / 24)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius:
                              BorderRadius.circular(screenWidth / (width / 16)),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).lineColor,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0,
                              screenWidth / (width / 16),
                              0,
                              screenWidth / (width / 12)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Add button, Title, Search textfield and icon
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Add Button and Title
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 5), 0, 0, 0),
                                        child: FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius:
                                              screenWidth / (width / 30),
                                          borderWidth: 1,
                                          buttonSize:
                                              screenWidth / (width / 50),
                                          icon: Icon(
                                            Icons.playlist_add,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            size: screenWidth / (width / 25),
                                          ),
                                          onPressed: () {
                                            dialogaddPractioner(context);
                                            _pullRefresh();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            screenWidth / (width / 5), 0, 0, 0),
                                        child: Text(
                                          'Practioners',
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Search textfield and icon
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: screenWidth / (width / 200),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  screenWidth / (width / 16),
                                                  0,
                                                  screenWidth / (width / 5)),
                                          child: Container(
                                            width: screenWidth / (width / 200),
                                            child: TextFormField(
                                              controller: textController,
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Search...',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: screenWidth /
                                                            (width / 14)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          screenWidth /
                                                              (width / 10)),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize:
                                                              screenWidth /
                                                                  (width / 14)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius:
                                            screenWidth / (width / 30),
                                        borderWidth: 1,
                                        buttonSize: screenWidth / (width / 50),
                                        icon: Icon(
                                          Icons.search,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: screenWidth / (width / 25),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //Column Title
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    screenWidth / (width / 12),
                                    screenWidth / (width / 12),
                                    screenWidth / (width / 12),
                                    0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      screenWidth / (width / 8),
                                                      0,
                                                      0,
                                                      0),
                                              child: Text(
                                                'Practioners',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText2
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
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Title',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                    ))
                                      Expanded(
                                        child: Text(
                                          'Roles',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                      Expanded(
                                        child: Text(
                                          'Speciality',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: screenWidth /
                                                      (width / 14)),
                                        ),
                                      ),
                                    Expanded(
                                      child: Text(
                                        'Action',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                                fontFamily: 'Poppins',
                                                fontSize:
                                                    screenWidth / (width / 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Data Row
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, screenWidth / (width / 16), 0, 0),
                                child: FutureBuilder(
                                    future: practionerList,
                                    builder: (context,
                                        AsyncSnapshot<List<PractionerData>>
                                            snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              retrievedPractionerList!.length,
                                          itemBuilder: (context, indexs) {
                                            return _buildTableUser(
                                                context,
                                                retrievedPractionerList![
                                                    indexs],
                                                retrievedPractionerList,
                                                indexs);
                                          },
                                        );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          retrievedPractionerList!.isEmpty) {
                                        return Center(
                                          child: ListView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            children: const <Widget>[
                                              Align(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Text('No Data Availble'),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, PractionerData snapshot,
      List<PractionerData>? user, int indexs) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
      padding:
          EdgeInsetsDirectional.fromSTEB(0, 0, 0, screenWidth / (width / 2)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color: FlutterFlowTheme.of(context).lineColor,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12),
              screenWidth / (width / 12)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Name
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      snapshot.firstName! + ' ' + snapshot.lastName!,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                            fontFamily: 'Poppins',
                            fontSize: screenWidth / (width / 16),
                          ),
                    ),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                //Title
                Expanded(
                  flex: 2,
                  child: Text(
                    snapshot.titleMain!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                //Roles
                Expanded(
                  child: Text(
                    snapshot.myRoles!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                //Speciality
                Expanded(
                  child: Text(
                    snapshot.mySpecialty!,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: screenWidth / (width / 14)),
                  ),
                ),
              //Action Button
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Edit button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, screenWidth / (width / 5), 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          dialogEditPractioner(context);
                          setState(() {
                            userId = snapshot.id;
                            firstNameID = snapshot.firstName;
                            lastNameID = snapshot.lastName;
                            myApproachID = snapshot.myApproach;
                            myBackgroundID = snapshot.myBackground;
                            myQualificationsID = snapshot.myQualifications;
                            mySpecialtyID = snapshot.mySpecialty;
                            myRolesID = snapshot.myRoles;
                            languagesID = snapshot.languages;
                            titleMainID = snapshot.titleMain;
                          });
                        },
                        text: 'Edit',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 75),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: screenWidth / (width / 15),
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: screenWidth / (width / 2.5),
                            ),
                            borderRadius: screenWidth / (width / 8)),
                      ),
                    ),
                    //Delete Button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          screenWidth / (width / 5), 0, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await service.deletePractioners(
                              context, snapshot.id.toString());
                          _pullRefresh();
                        },
                        text: 'Delete',
                        options: FFButtonOptions(
                            width: screenWidth / (width / 75),
                            height: screenWidth / (width / 35),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: screenWidth / (width / 15),
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: screenWidth / (width / 2.5),
                            ),
                            borderRadius: screenWidth / (width / 8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogEditPractioner(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Services"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(screenWidth / (width / 40)),
                  top: -(screenWidth / (width / 80)),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _firstNamePractioner,
                            decoration: InputDecoration(
                              labelText: "First Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _lastNamePractioner,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myApproachPractioner,
                            decoration: InputDecoration(
                              labelText: "My Approach",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myBackgroundPractioner,
                            decoration: InputDecoration(
                              labelText: "My Backgrounds",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myQualificationsPractioner,
                            decoration: InputDecoration(
                              labelText: "My Qualifications",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _mySpecialtyPractioner,
                            decoration: InputDecoration(
                              labelText: "My Specialty",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myRolesPractioner,
                            decoration: InputDecoration(
                              labelText: "My Roles",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _languagesPractioner,
                            decoration: InputDecoration(
                              labelText: "Languages",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _titleMainPractioner,
                            decoration: InputDecoration(
                              labelText: "Title Main",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2022), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2023));

                              var time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());

                              // DateTimeRange? pickedRange =
                              //     await showDateRangePicker(
                              //   context: context,
                              //   firstDate: DateTime.now(),
                              //   lastDate: DateTime(2023),
                              //   // initialDateRange: dateRange.value
                              // );

                              if (pickedDate != null &&
                                  // pickedRange != null &&
                                  time != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement
                                setState(() {
                                  _schedulePractioner.text = formattedDate +
                                      " " +
                                      "${time.hour}:${time.minute}";

                                  //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            controller: _schedulePractioner,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Schedule",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenWidth / (width / 40),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                PractionerData practionerData = PractionerData(
                                  id: userId,
                                  firstName: _firstNamePractioner.text,
                                  lastName: _lastNamePractioner.text,
                                  myApproach: _myApproachPractioner.text,
                                  myBackground: _myBackgroundPractioner.text,
                                  myQualifications:
                                      _myQualificationsPractioner.text,
                                  mySpecialty: _mySpecialtyPractioner.text,
                                  myRoles: _myRolesPractioner.text,
                                  languages: _languagesPractioner.text,
                                  titleMain: _titleMainPractioner.text,
                                );
                                await service.updatePractioners(practionerData);
                                Navigator.pop(context);
                                _pullRefresh();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogaddPractioner(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double width = ResponsiveWidget.isphoneScreen(context)
        ? 414
        : ResponsiveWidget.isSmallScreen(context)
            ? 912
            : ResponsiveWidget.isLargeScreen(context)
                ? 1920
                : 1280;
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new services"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(screenWidth / (width / 40)),
                  top: -(screenWidth / (width / 80)),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _firstNamePractioner,
                            decoration: InputDecoration(
                              labelText: "Enter First Name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter correct name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _lastNamePractioner,
                            decoration: InputDecoration(
                              labelText: "Enter last name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter correct name";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myApproachPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my approach",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter approach";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myBackgroundPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my background",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter background";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myQualificationsPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my qualifications",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter qualifications";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _mySpecialtyPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my specialty",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter specialty";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _myRolesPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my roles",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter roles";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _languagesPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter my languges",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter languages";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: TextFormField(
                            controller: _titleMainPractioner,
                            decoration: InputDecoration(
                              labelText: "Enter title main",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter title main";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenWidth / (width / 40),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / (width / 8)),
                          child: ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                PractionerData practionerData = PractionerData(
                                  id: userId,
                                  firstName: _firstNamePractioner.text,
                                  lastName: _lastNamePractioner.text,
                                  myApproach: _myApproachPractioner.text,
                                  myBackground: _myBackgroundPractioner.text,
                                  myQualifications:
                                      _myQualificationsPractioner.text,
                                  mySpecialty: _mySpecialtyPractioner.text,
                                  myRoles: _myRolesPractioner.text,
                                  languages: _languagesPractioner.text,
                                  titleMain: _titleMainPractioner.text,
                                );
                                await service.addPractioners(practionerData);
                                Navigator.pop(context);
                                _pullRefresh();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
