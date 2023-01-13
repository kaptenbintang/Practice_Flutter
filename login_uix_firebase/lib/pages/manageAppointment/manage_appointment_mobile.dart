// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_uix_firebase/helper/dimensions.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../helper/database_service.dart';
import '../../model/appointment_data.dart';
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
  Future<List<AppointmentData>>? AppointmentList;
  Map<String, dynamic>? currentAppointmentData;
  List<AppointmentData>? retrievedAppointmentList;
  GlobalKey<ScaffoldState>? _scaffoldKey;
  List<Map<String, dynamic>>? listofColumn;
  PractionerData? dataU;
  final FocusNode dropDownFocus = FocusNode();

  final _practionername = TextEditingController();
  final _location = TextEditingController();
  final _services = TextEditingController();
  final _dateandtime = TextEditingController();
  final _clientcodeorname = TextEditingController();
  final _clientphnumber = TextEditingController();
  final _clientemail = TextEditingController();
  final _clientcomment = TextEditingController();
  final _statusAppointment = TextEditingController();
  final _createdAt = TextEditingController();

  String? userId;
  String? PractionerNameID;
  String? locationID;
  String? servicesID;
  String? dateandtimeID;
  String? clientCodeorNameID;
  String? clientphNumberID;
  String? clientEmail;
  String? clientcommentID;
  String? statusAppointmentID;
  String? createdAtID;
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
    AppointmentList = service.retrieveApppointmentAll();
    retrievedAppointmentList = await service.retrieveApppointmentAll();
    selected = List<bool>.generate(
        retrievedAppointmentList!.length, (int index) => false);
  }

  Future<void> _pullRefresh() async {
    retrievedAppointmentList = await service.retrieveApppointmentAll();

    setState(() {
      AppointmentList = service.retrieveApppointmentAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            Dimensions.height08 * 2,
            Dimensions.height08 * 2,
            Dimensions.height08 * 2,
            Dimensions.height08 * 2),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: Dimensions.height08 / 2,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(Dimensions.height08 * 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title and subtitle
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(Dimensions.height08 * 2,
                    Dimensions.height08 * 2, 0, Dimensions.height08 * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Text(
                      'Dashboard',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                    // subtitle
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
                    Dimensions.height08 * 2, 0, Dimensions.height08 * 2, 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius:
                        BorderRadius.circular(Dimensions.height08 * 2),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).lineColor,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, Dimensions.height08 * 2, 0, Dimensions.height24 / 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Container title
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              Dimensions.height08 * 2, 0, 0, 0),
                          child: Text(
                            'Appoinments',
                            style: FlutterFlowTheme.of(context).title3,
                          ),
                        ),
                        //Search textfield icon, add button
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      Dimensions.height10,
                                      Dimensions.height05,
                                      0,
                                      Dimensions.height05),
                                  child: Container(
                                    width: Dimensions.height100 +
                                        Dimensions.height10 * 5,
                                    child: TextFormField(
                                      controller: textController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 3),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 3),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius15 / 3),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
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
                                      Dimensions.height05, 0, 0, 0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: Dimensions.radius30,
                                    borderWidth: 1,
                                    buttonSize: Dimensions.height20 * 2,
                                    icon: Icon(
                                      Icons.search,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: Dimensions.height20,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: Dimensions.radius30,
                              borderWidth: 1,
                              buttonSize: Dimensions.height20 * 2,
                              icon: Icon(
                                Icons.playlist_add,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: Dimensions.height20,
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
                              Dimensions.height24 / 2,
                              Dimensions.height24 / 2,
                              Dimensions.height24 / 2,
                              0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //left title
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    Dimensions.height10, 0, 0, 0),
                                child: Text(
                                  'Appoinment',
                                  style: FlutterFlowTheme.of(context).bodyText2,
                                ),
                              ),
                              //right title
                              Expanded(
                                child: Text(
                                  'Action',
                                  textAlign: TextAlign.end,
                                  style: FlutterFlowTheme.of(context).bodyText2,
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
                              future: AppointmentList,
                              builder: (context,
                                  AsyncSnapshot<List<AppointmentData>>
                                      snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: retrievedAppointmentList!.length,
                                    itemBuilder: (context, indexs) {
                                      return _buildTableUser(
                                          context,
                                          retrievedAppointmentList![indexs],
                                          retrievedAppointmentList,
                                          indexs);
                                    },
                                  );
                                } else if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    retrievedAppointmentList!.isEmpty) {
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
      ),
    );
  }

  _buildTableUser(BuildContext context, AppointmentData snapshot,
      List<AppointmentData>? user, int indexs) {
    // print(_isChecked);
    // int idx = int.parse(dropDownItemValue2[indexs]);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, Dimensions.height10 / 5),
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
              Dimensions.height24 / 2,
              Dimensions.height24 / 2,
              Dimensions.height24 / 2,
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
                    //clientCode
                    AutoSizeText(
                      snapshot.clientNameorCode!,
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      //date
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, Dimensions.height10 / 5, 0, 0),
                        child: Text(
                          snapshot.date!,
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ),
                    //status
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, Dimensions.height10 / 5, 0, 0),
                      child: Text(
                        snapshot.statusAppointment!,
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
                        iconSize: Dimensions.height20 * 2,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: Dimensions.height20,
                        ),
                        onChanged: (value) {
                          // if value doesnt contain just close the dropDown
                          if (value == null) {
                            dropDownFocus.unfocus();
                          } else {
                            switch (value) {
                              case "Remove":
                                () async {
                                  print('Button pressed ...');
                                  await service.deleteAppointment(
                                      context, snapshot.clientId.toString());
                                  _pullRefresh();
                                };
                                break;
                              case "Edit":
                                dialogEditPractioner(context);
                                setState(() {
                                  userId = snapshot.clientId;
                                  _practionername.text =
                                      snapshot.practionerName.toString();
                                  _services.text = snapshot.services.toString();
                                  _location.text = snapshot.location.toString();
                                  _dateandtime.text = snapshot.date.toString();
                                  _clientcodeorname.text =
                                      snapshot.clientNameorCode.toString();
                                  _clientphnumber.text =
                                      snapshot.clientphNumber.toString();
                                  _clientemail.text =
                                      snapshot.clientEmail.toString();
                                  _clientcomment.text =
                                      snapshot.clientComment.toString();
                                  _statusAppointment.text =
                                      snapshot.statusAppointment.toString();
                                  _createdAt.text =
                                      snapshot.createdAt.toString();
                                });
                                break;
                              default:
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Action',
                                style: FlutterFlowTheme.of(context).bodyText1),
                            value: "Action",
                          ),
                          DropdownMenuItem(
                            child: Text('Edit',
                                style: FlutterFlowTheme.of(context).bodyText1),
                            value: "Edit",
                          ),
                          DropdownMenuItem(
                            child: Text('Remove',
                                style: FlutterFlowTheme.of(context).bodyText1),
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
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Appointment"),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -Dimensions.width20 * 2,
                  top: -Dimensions.height20 * 4,
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
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _practionername,
                            decoration: InputDecoration(
                              labelText: "Practioner Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _services,
                            decoration: InputDecoration(
                              labelText: "Services",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _location,
                            decoration: InputDecoration(
                              labelText: "Location",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _dateandtime,
                            decoration: InputDecoration(
                              labelText: "Date/Time",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _clientcodeorname,
                            decoration: InputDecoration(
                              labelText: "Code or Name",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _clientphnumber,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _clientemail,
                            decoration: InputDecoration(
                              labelText: "Client Email",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _clientcomment,
                            decoration: InputDecoration(
                              labelText: "Comment",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: DropdownButtonFormField(
                            value: _statusAppointment.text,
                            decoration: InputDecoration(
                              labelText: "Status",
                            ),
                            // icon: Icon(
                            //   Icons.edit,
                            //   color: Colors.blue,
                            // ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _statusAppointment.text = value!;
                              });
                            },
                            onSaved: (value) {},
                            items: <String>['ongoing', 'Complete', 'Cancel']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.height08),
                          child: TextFormField(
                            controller: _createdAt,
                            decoration: InputDecoration(
                              labelText: "CreatedAt",
                            ),
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
                                AppointmentData appointmentData =
                                    AppointmentData(
                                        clientId: userId,
                                        practionerName: _practionername.text,
                                        services: _services.text,
                                        location: _location.text,
                                        date: _dateandtime.text,
                                        clientNameorCode:
                                            _clientcodeorname.text,
                                        clientphNumber: _clientphnumber.text,
                                        clientEmail: _clientemail.text,
                                        clientComment: _clientcomment.text,
                                        statusAppointment:
                                            _statusAppointment.text,
                                        createdAt: _createdAt.text);
                                await service
                                    .updateAppointment(appointmentData);
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
                ),
              ],
            ),
          );
        });
  }

  // Future<dynamic> dialogaddPractioner(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("Add new Appoinment"),
  //           content: Stack(
  //             clipBehavior: Clip.none,
  //             children: <Widget>[
  //               Positioned(
  //                 right: -40.0,
  //                 top: -80.0,
  //                 child: InkResponse(
  //                   onTap: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: CircleAvatar(
  //                     child: Icon(Icons.close),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //               Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _firstNamePractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter First Name",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter correct name";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _lastNamePractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter last name",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter correct name";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _myApproachPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my approach",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter approach";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _myBackgroundPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my background",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter background";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _myQualificationsPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my qualifications",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter qualifications";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _mySpecialtyPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my specialty",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter specialty";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _myRolesPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my roles",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter roles";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _languagesPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter my languges",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter languages";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimensions.height08),
  //                       child: TextFormField(
  //                         controller: _titleMainPractioner,
  //                         decoration: InputDecoration(
  //                           labelText: "Enter title main",
  //                         ),
  //                         validator: (value) {
  //                           if (value!.isEmpty) {
  //                             return "Enter title main";
  //                           } else {
  //                             return null;
  //                           }
  //                         },
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: Dimensions.height20*2,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(Dimensions.height08),
  //                       child: ElevatedButton(
  //                         child: Text("Submit"),
  //                         onPressed: () async {
  //                           if (_formKey.currentState!.validate()) {
  //                             PractionerData practionerData = PractionerData(
  //                               id: userId,
  //                               firstName: _firstNamePractioner.text,
  //                               lastName: _lastNamePractioner.text,
  //                               myApproach: _myApproachPractioner.text,
  //                               myBackground: _myBackgroundPractioner.text,
  //                               myQualifications:
  //                                   _myQualificationsPractioner.text,
  //                               mySpecialty: _mySpecialtyPractioner.text,
  //                               myRoles: _myRolesPractioner.text,
  //                               languages: _languagesPractioner.text,
  //                               titleMain: _titleMainPractioner.text,
  //                             );
  //                             await service.addPractioners(practionerData);
  //                             Navigator.pop(context);
  //                             _pullRefresh();
  //                           }

  //                           // if (_formKey.currentState!.validate()) {
  //                           //   _formKey.currentState!.save();
  //                           // }
  //                         },
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
