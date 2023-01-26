// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../model/manage_practioner_data.dart';
import '../../model/practioner_data.dart';

class ManagePractionerMobile extends StatefulWidget {
  const ManagePractionerMobile({super.key});

  @override
  State<ManagePractionerMobile> createState() => _ManagePractionerMobileState();
}

class _ManagePractionerMobileState extends State<ManagePractionerMobile> {
  TextEditingController? textController;
  DataService service = DataService();
  Future<List<PractionerData>>? practionerList;
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
    super.initState();
    _scaffoldKey = GlobalKey();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            Dimensions.width16,
            Dimensions.height08 * 2,
            Dimensions.width16,
            Dimensions.height08 * 2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, Dimensions.height08 / 4),
              )
            ],
            borderRadius: BorderRadius.circular(Dimensions.font16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(Dimensions.width16,
                    Dimensions.height08 * 2, 0, Dimensions.height08 * 2),
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
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height08 / 2, 0, 0),
                      child: Text(
                        'Your project status is appearing here.',
                        style: FlutterFlowTheme.of(context).bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    Dimensions.width24 - Dimensions.width10,
                    0,
                    Dimensions.width24 - Dimensions.width10,
                    Dimensions.height24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(Dimensions.font16),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).lineColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, Dimensions.height08 * 2, 0, Dimensions.height24 / 2),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Container title
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.width08 * 2, 0, 0, 0),
                            child: Text(
                              'Practioners',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                          //Search textfield icon, add button
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10,
                                          Dimensions.height05,
                                          0,
                                          Dimensions.height05),
                                      child: Container(
                                        width: Dimensions.width100 +
                                            Dimensions.width10 * 5,
                                        child: TextFormField(
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Search...',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 3),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                lineHeight: 1.01,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10 / 2, 0, 0, 0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: Dimensions.radius30,
                                        borderWidth: 1,
                                        buttonSize: Dimensions.font20 * 2,
                                        icon: Icon(
                                          Icons.search,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: Dimensions.font20,
                                        ),
                                        onPressed: () {
                                          print('IconButton pressed ...');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: Dimensions.radius30,
                                borderWidth: 1,
                                buttonSize: Dimensions.font20 * 2,
                                icon: Icon(
                                  Icons.playlist_add,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: Dimensions.font20,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                  dialogaddPractioner(context);
                                  _pullRefresh();
                                },
                              ),
                            ],
                          ),
                          //Column title
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                Dimensions.width24 / 2,
                                Dimensions.height24 / 2,
                                Dimensions.width24 / 2,
                                0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          Dimensions.width10, 0, 0, 0),
                                      child: Text(
                                        'Practioners',
                                        style: FlutterFlowTheme.of(context)
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
                                        FlutterFlowTheme.of(context).bodyText2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Data row
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, Dimensions.height08 * 2, 0, 0),
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
                                            retrievedPractionerList![indexs],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTableUser(BuildContext context, PractionerData snapshot,
      List<PractionerData>? user, int indexs) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height08 / 4),
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
              Dimensions.width24 / 2,
              Dimensions.height24 / 2,
              Dimensions.width24 / 2,
              Dimensions.height24 / 2),
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
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, Dimensions.height08 / 4, 0, 0),
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
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusNode: dropDownFocus,
                        isExpanded: true,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        iconSize: Dimensions.font20 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: Dimensions.font20,
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
                                  myQualificationsID =
                                      snapshot.myQualifications;
                                  mySpecialtyID = snapshot.mySpecialty;
                                  myRolesID = snapshot.myRoles;
                                  languagesID = snapshot.languages;
                                  titleMainID = snapshot.titleMain;
                                });
                                break;
                              default:
                            }
                          }
                        },
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
        builder: (context) {
          return AlertDialog(
            title: const Text("Edit Services"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width10 * 4),
                  top: -(Dimensions.height20 * 4),
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //First Name
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _firstNamePractioner,
                            decoration: InputDecoration(
                              labelText: "First Name",
                            ),
                          ),
                        ),
                        //Last Name
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _lastNamePractioner,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                            ),
                          ),
                        ),
                        //My Approach
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _myApproachPractioner,
                            decoration: InputDecoration(
                              labelText: "My Approach",
                            ),
                          ),
                        ),
                        //My Background
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _myBackgroundPractioner,
                            decoration: InputDecoration(
                              labelText: "My Backgrounds",
                            ),
                          ),
                        ),
                        //My Qualifications
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _myQualificationsPractioner,
                            decoration: InputDecoration(
                              labelText: "My Qualifications",
                            ),
                          ),
                        ),
                        //My Speciality
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _mySpecialtyPractioner,
                            decoration: InputDecoration(
                              labelText: "My Specialty",
                            ),
                          ),
                        ),
                        //My Roles
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _myRolesPractioner,
                            decoration: InputDecoration(
                              labelText: "My Roles",
                            ),
                          ),
                        ),
                        //Languages
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _languagesPractioner,
                            decoration: InputDecoration(
                              labelText: "Languages",
                            ),
                          ),
                        ),
                        //Title Main
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _titleMainPractioner,
                            decoration: InputDecoration(
                              labelText: "Title Main",
                            ),
                          ),
                        ),
                        //Schedule
                        // Padding(
                        //   padding: EdgeInsets.all(Dimensions.height08),
                        //   child: TextFormField(
                        //     onTap: () async {
                        //       DateTime? pickedDate = await showDatePicker(
                        //           context: context,
                        //           initialDate: DateTime.now(),
                        //           firstDate: DateTime(
                        //               2022), //DateTime.now() - not to allow to choose before today.
                        //           lastDate: DateTime(2023));

                        //       var time = await showTimePicker(
                        //           context: context,
                        //           initialTime: TimeOfDay.now());

                        //       if (pickedDate != null && time != null) {
                        //         //pickedDate output format => 2021-03-10 00:00:00.000
                        //         String formattedDate =
                        //             DateFormat('yyyy-MM-dd').format(pickedDate);
                        //         //formatted date output using intl package =>  2021-03-16
                        //         //you can implement different kind of Date Format here according to your requirement
                        //         setState(() {
                        //           _schedulePractioner.text = formattedDate +
                        //               " " +
                        //               "${time.hour}:${time.minute}";

                        //           //set output date to TextField value.
                        //         });
                        //       } else {
                        //         print("Date is not selected");
                        //       }
                        //     },
                        //     controller: _schedulePractioner,
                        //     readOnly: true,
                        //     decoration: InputDecoration(
                        //       labelText: "Schedule",
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: Dimensions.height20 * 2,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: ElevatedButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                managePractionerData practionerData =
                                    managePractionerData(
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
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance
        .collection('servicesCategory')
        .snapshots(includeMetadataChanges: true);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add new Practioner"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -(Dimensions.width10 * 4),
                  top: -(Dimensions.height20 * 4),
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          padding: EdgeInsets.all(Dimensions.height08),
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
                          height: Dimensions.height20 * 2,
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
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
