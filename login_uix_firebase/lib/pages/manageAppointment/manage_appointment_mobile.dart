// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../helper/database_service.dart';
import '../../model/practioner_data.dart';

class ManageAppointmentMobile extends StatefulWidget {
  const ManageAppointmentMobile({super.key});

  @override
  State<ManageAppointmentMobile> createState() =>
      _ManageAppointmentMobileState();
}

class _ManageAppointmentMobileState extends State<ManageAppointmentMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<PractionerData>>? PractionerList;
  Map<String, dynamic>? currentPractionerData;
  List<PractionerData>? retrievedPractionerList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  PractionerData? dataU;
  final FocusNode dropDownFocus = FocusNode();

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
    // TODO: implement initState
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    // listofColumn = (await service.retrieveClientType()).cast<Map<String, dynamic>>();
    PractionerList = service.retrievePractionerAll();
    retrievedPractionerList = await service.retrievePractionerAll();
    selected = List<bool>.generate(
        retrievedPractionerList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedPractionerList = await service.retrievePractionerAll();

    setState(() {
      PractionerList = service.retrievePractionerAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Container(
                  width: double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                ),
              ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Your project status is appearing here.',
                              style: FlutterFlowTheme.of(context).bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(4, 0, 4, 24),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).lineColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 16, 0, 12),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Container title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: Text(
                                          'Practioners',
                                          style: FlutterFlowTheme.of(context)
                                              .title3,
                                        ),
                                      ),
                                      //Search textfield icon, add button
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 5, 0, 5),
                                                  child: Container(
                                                    width: 150,
                                                    child: TextFormField(
                                                      controller:
                                                          textController,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Search...',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            lineHeight: 1.01,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: FlutterFlowIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 30,
                                                    borderWidth: 1,
                                                    buttonSize: 40,
                                                    icon: Icon(
                                                      Icons.search,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 30,
                                            borderWidth: 1,
                                            buttonSize: 40,
                                            icon: Icon(
                                              Icons.playlist_add,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              print('IconButton pressed ...');
                                            },
                                          ),
                                        ],
                                      ),
                                      //Column title
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Text(
                                                    'Practioners',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Action',
                                                textAlign: TextAlign.end,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //Data row
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 0),
                                        child: FutureBuilder(
                                            future: PractionerList,
                                            builder: (context,
                                                AsyncSnapshot<
                                                        List<PractionerData>>
                                                    snapshot) {
                                              if (snapshot.hasData &&
                                                  snapshot.data!.isNotEmpty) {
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      retrievedPractionerList!
                                                          .length,
                                                  itemBuilder:
                                                      (context, indexs) {
                                                    return _buildTableUser(
                                                        context,
                                                        retrievedPractionerList![
                                                            indexs],
                                                        retrievedPractionerList,
                                                        indexs);
                                                  },
                                                );
                                              } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done &&
                                                  retrievedPractionerList!
                                                      .isEmpty) {
                                                return Center(
                                                  child: ListView(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    children: const <Widget>[
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: Text(
                                                            'No Data Availble'),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }),
                                      ),
                                    ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, PractionerData snapshot,
      List<PractionerData>? user, int indexs) {
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
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
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //pic and name roles
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    AutoSizeText(
                      snapshot.firstName! + ' ' + snapshot.lastName!,
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      //role
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          snapshot.myRoles!,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                  ],
                ),
              ),
              //dropdown
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      focusNode: dropDownFocus,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(30),
                      iconSize: 40,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      onChanged: (value) {
                        print(value);
                        // if value doesnt contain just close the dropDown
                        if (value == null) {
                          dropDownFocus.unfocus();
                        } else {
                          switch (value) {
                            case "Remove":
                              print('Button pressed ...');
                              service.deletePractioners(
                                  context, snapshot.id.toString());
                              _pullRefresh();
                              break;
                            case "Edit":
                              print('Button pressed ...');
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
                                schedulePractionerID =
                                    snapshot.practionerSchedule;
                              });
                              break;
                            default:
                          }
                        }
                      },
                      // items: List.generate(
                      //     dropDownItemValue2.length,
                      //     (index) => DropdownMenuItem(
                      //           value: dropDownItemValue2[index],
                      //           child: Text(dropDownItemValue2[index]),
                      //         )),
                      items: [
                        DropdownMenuItem(
                          child: Text('Action'),
                          value: "Action",
                        ),
                        DropdownMenuItem(
                          child: Text('Edit'),
                          value: "Edit",
                        ),
                        DropdownMenuItem(
                          child: Text('Remove'),
                          value: "Remove",
                        ),
                      ],
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
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Services"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -80.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _firstNamePractioner,
                          decoration: InputDecoration(
                            labelText: "First Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _lastNamePractioner,
                          decoration: InputDecoration(
                            labelText: "Last Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myApproachPractioner,
                          decoration: InputDecoration(
                            labelText: "My Approach",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myBackgroundPractioner,
                          decoration: InputDecoration(
                            labelText: "My Backgrounds",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myQualificationsPractioner,
                          decoration: InputDecoration(
                            labelText: "My Qualifications",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _mySpecialtyPractioner,
                          decoration: InputDecoration(
                            labelText: "My Specialty",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _myRolesPractioner,
                          decoration: InputDecoration(
                            labelText: "My Roles",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _languagesPractioner,
                          decoration: InputDecoration(
                            labelText: "Languages",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _titleMainPractioner,
                          decoration: InputDecoration(
                            labelText: "Title Main",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2022), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2023));

                            var time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

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
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
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
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                  practionerSchedule: _schedulePractioner.text);
                              await service.updatePractioners(practionerData);
                              Navigator.pop(context);
                              _pullRefresh();
                            }

                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> dialogaddPractioner(BuildContext context) {
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
                  right: -40.0,
                  top: -80.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        padding: EdgeInsets.all(8.0),
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
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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

                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
